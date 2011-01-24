AS=yasm
ASFLAGS32= -gdwarf2 -felf32
ASFLAGS64= -gdwarf2 -felf64
CFLAGS= -gdwarf-2

LDFLAGS= 
LIB_NAME=libimgdiff

$(LIB_NAME)32.o: libimgdiff.asm libimgdiff.h
	$(AS) $(ASFLAGS32) $< -o $@

$(LIB_NAME)64.o: libimgdiff.asm libimgdiff.h
	$(AS) $(ASFLAGS64) $< -o $@

$(LIB_NAME)32.so:	$(LIB_NAME)32.o
	gcc -shared $(CFLAGS) -o $@ $^

$(LIB_NAME)64.so:	$(LIB_NAME)64.o
	gcc -shared $(CFLAGS) -o $@ $^

test32: test.c $(LIB_NAME)32.so
	gcc -fPIC -gstabs  -o $@ $^
	LD_LIBRARY_PATH=. ./test32

test64: test.c $(LIB_NAME)64.so
	gcc -fPIC -gstabs  -o $@ $^
	LD_LIBRARY_PATH=. ./test64

pkg: clean
	mkdir $(LIB_NAME) 
	cp Makefile $(LIB_NAME).* defines.mac test.c $(LIB_NAME)/
	tar cvzf $(LIB_NAME).tar.gz $(LIB_NAME)/
	rm -r $(LIB_NAME)/

clean:
	rm -f *.o *.a
	rm -f $(LIB_NAME)32.so $(LIB_NAME)64.so test32 test64
	rm -f $(LIB_NAME).tar.gz

.PHONY: clean pkg test
