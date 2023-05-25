CFLAGS = -Wall -Wextra -std=c99 -pedantic
LDFLAGS =

BIN = bin2uf2 uf22bin uf2dump
SRC = libuf2.c
OBJ = $(SRC:.c=.o)

bin2uf2: bin2uf2.o
uf22bin: uf22bin.o
uf2dump: uf2dump.o

$(BIN): $(OBJ)
	$(CC) $(LDFLAGS) $(OBJ) $@.o -o $@

.c.o:
	$(CC) $(CFLAGS) -c $< -o $@