TOPDIR := ..
LIB := libthreadpool.a
CDIR := src/

all: $(LIB)

include $(TOPDIR)/makerules

LIBFILES = \
	src/threadpool \

OBJFILES = $(addsuffix .o, $(LIBFILES))

libthreadpool.a: $(OBJFILES)
	$(AR) qc $@ $^

# From here on, Makefile from the original author.

#CFLAGS = -D_REENTRANT -Wall -pedantic -Isrc
LDLIBS = -lpthread

ifdef DEBUG
CFLAGS += -g
LDFLAGS += -g
endif

TARGETS = tests/thrdtest tests/heavy tests/shutdown

#all: $(TARGETS)

tests/shutdown: tests/shutdown.o src/threadpool.o
tests/thrdtest: tests/thrdtest.o src/threadpool.o
tests/heavy: tests/heavy.o src/threadpool.o
src/threadpool.o: src/threadpool.c src/threadpool.h
tests/thrdtest.o: tests/thrdtest.c src/threadpool.h
tests/heavy.o: tests/heavy.c src/threadpool.h

#clean:
#	rm -f $(TARGETS) *~ */*~ */*.o
