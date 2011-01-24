#  File:      Makefile
#  Date:      23.01.2011
#  Author:    <Radek Fer> xferra00@stud.fit.vutbr.cz
#  Project:   libimg_sse
#  Description:
#
#  Copyright (C) 2002 Radek Fer
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License as
#  published by the Free Software Foundation; either version 2 of the
#  License, or (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful, but
#  WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#  General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  in a file called COPYING along with this program; if not, write to
#  the Free Software Foundation, Inc., 675 Mass Ave, Cambridge, MA
#  02139, USA.
LIB_NAME=libimg_sse
AS=yasm
ASFLAGS32= -gdwarf2 -felf32
ASFLAGS64= -gdwarf2 -felf64
CFLAGS= -gdwarf-2

$(LIB_NAME)32.o: $(LIB_NAME).asm $(LIB_NAME).h
	$(AS) $(ASFLAGS32) $< -o $@

$(LIB_NAME)64.o: $(LIB_NAME).asm $(LIB_NAME).h
	$(AS) $(ASFLAGS64) $< -o $@

$(LIB_NAME)32.so:	$(LIB_NAME)32.o
	gcc -shared $(CFLAGS) -o $@ $^

$(LIB_NAME)64.so:	$(LIB_NAME)64.o
	gcc -shared $(CFLAGS) -o $@ $^

test32: test.c $(LIB_NAME)32.so
	gcc -fPIC $(CFLAGS) -o $@ $^
	LD_LIBRARY_PATH=. ./test32

test64: test.c $(LIB_NAME)64.so
	gcc -fPIC $(CFLAGS) -o $@ $^
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
