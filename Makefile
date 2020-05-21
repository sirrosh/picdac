SRC=sine.c
SRCMAIN=main.c
CC=sdcc
FAMILY=pic14
PROC=16f648a
DEPS=sine.h
CFLAGS = --use-non-free
PR=pk2cmd
PRFLAGS=-B/usr/share/pk2/ -P

OBJS = $(patsubst %.c,%.o,$(SRC))

#all: $(SRC:.c=.hex)


#$(SRC:.c=.hex): $(SRC)
#	$(CC) $(CFLAGS) -m$(FAMILY) -p$(PROC) $^

%.o: %.c
	$(CC) $(CFLAGS) -c -m$(FAMILY) -p$(PROC) $<

main: $(OBJS)
	$(CC) $(CFLAGS) -m$(FAMILY) -p$(PROC) $(SRCMAIN) $(OBJS)

clean:
	rm -f $(SRC:.c=.asm) $(SRC:.c=.cod) $(SRC:.c=.hex) $(SRC:.c=.lst) $(SRC:.c=.o)
	rm -f $(SRCMAIN:.c=.asm) $(SRCMAIN:.c=.cod) $(SRCMAIN:.c=.hex) $(SRCMAIN:.c=.lst) $(SRCMAIN:.c=.o)

erase:
	$(PR) $(PRFLAGS) -I

flash:
	$(PR) $(PRFLAGS) -F$(SRCMAIN:.c=.hex) -M -Y


.PHONY: all clean flash erase
