CC = gcc
CPP = g++
CFLAGS = -Wall -O2

all: tsncard

tsncard: server.o message.o dataloader.o flow.o utils.o
	$(CPP) $(CFLAGS) -o tsncard server.o message.o dataloader.o flow.o utils.o -pthread

switch_main: switch.o message.o md5.o dma-proxy.o buffer_queue.o
	$(CPP) $(CFLAGS) -o switch_main switch.o message.o md5.o dma-proxy.o buffer_queue.o -pthread

message.o: Utils/message.cpp
	$(CPP) $(CFLAGS) -c Utils/message.cpp -o message.o

utils.o: Utils/utils.cpp
	$(CPP) $(CFLAGS) -c Utils/utils.cpp -o utils.o

server.o: server/main.cpp
	$(CPP) $(CFLAGS) -c server/main.cpp -o server.o

flow.o: server/flow.cpp
	$(CPP) $(CFLAGS) -c server/flow.cpp -o flow.o

dataloader.o: server/dataloader.cpp
	$(CPP) $(CFLAGS) -c server/dataloader.cpp -o dataloader.o

switch.o: switch/main.cpp
	$(CPP) $(CFLAGS) -c switch/main.cpp -o switch.o

md5.o:
	$(CPP) $(CFLAGS) -c switch/md5/md5.cpp -o md5.o

buffer_queue.o:
	${CC} -O2 -c switch/dma_proxy/buffer_queue.c -o buffer_queue.o

dma-proxy.o:
	${CC} -O2 -c switch/dma_proxy/dma-proxy.c -o dma-proxy.o

clean:
	rm -f *.o tsncard switch_main