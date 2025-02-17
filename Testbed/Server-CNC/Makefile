CC = gcc
CPP = g++
CFLAGS = -Wall -O2

all: tsncard

tsncard: server.o message.o dataloader.o flow.o utils.o
	$(CPP) $(CFLAGS) -o tsncard server.o message.o dataloader.o flow.o utils.o -pthread

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

clean:
	rm -f *.o tsncard 