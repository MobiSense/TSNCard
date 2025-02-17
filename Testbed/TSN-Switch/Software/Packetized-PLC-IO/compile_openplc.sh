#!/bin/bash
echo "Copy blank.cpp to hardware_layer.cpp..."
cp hardware_layers/blank.cpp hardware_layer.cpp 

#move into the scripts folder if you're not there already
OPENPLC_PLATFORM=$(cat ../scripts/openplc_platform)

#compiling the ST file into C
cd ..
echo "Optimizing ST program..."
./st_optimizer ./core/st_files/test.st ./core/st_files/test.st
echo "Generating C files..."
./iec2c -f -l -p -r -R -a ./core/st_files/test.st
if [ $? -ne 0 ]; then
    echo "Error generating C files"
    echo "Compilation finished with errors!"
    exit 1
fi
echo "Moving Files..."
mv -f POUS.c POUS.h LOCATED_VARIABLES.h VARIABLES.csv Config0.c Config0.h Res0.c ./core/
if [ $? -ne 0 ]; then
    echo "Error moving files"
    echo "Compilation finished with errors!"
    exit 1
fi

#compiling for each platform
cd core

echo "Compiling for Linux"
echo "Generating object files..."
g++ -std=gnu++11 -I ./lib -c Config0.c -lasiodnp3 -lasiopal -lopendnp3 -lopenpal -w
if [ $? -ne 0 ]; then
    echo "Error compiling C files"
    echo "Compilation finished with errors!"
    exit 1
fi
g++ -std=gnu++11 -I ./lib -c Res0.c -lasiodnp3 -lasiopal -lopendnp3 -lopenpal -w
if [ $? -ne 0 ]; then
    echo "Error compiling C files"
    echo "Compilation finished with errors!"
    exit 1
fi
echo "Generating glueVars..."
./glue_generator
echo "Compiling main program..."
g++ -std=gnu++11 tsn_drivers/rtc.c tsn_drivers/uio.c tsn_drivers/ptp_types.c tsn_drivers/gpio_reset.c *.cpp *.o -o openplc -I ./lib -pthread -fpermissive `pkg-config --cflags --libs libmodbus` -lasiodnp3 -lasiopal -lopendnp3 -lopenpal -w
if [ $? -ne 0 ]; then
    echo "Error compiling C files"
    echo "Compilation finished with errors!"
    exit 1
fi
echo "Compilation finished successfully!"
exit 0

