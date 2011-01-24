/*
   File:      test.c
   Date:      23.01.2011 23:08
   Author:    xferra00
   Project:   

   Copyright (C) 2002 xferra00

   This program is free software; you can redistribute it and/or
   modify it under the terms of the GNU General Public License as
   published by the Free Software Foundation; either version 2 of the
   License, or (at your option) any later version.

   This program is distributed in the hope that it will be useful, but
   WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   General Public License for more details.

   You should have received a copy of the GNU General Public License
   in a file called COPYING along with this program; if not, write to
   the Free Software Foundation, Inc., 675 Mass Ave, Cambridge, MA
   02139, USA.
*/

#include <stdio.h>
#include <stdlib.h>
#include "libimgdiff.h"

int main(int argc, char *argv[])
{
  unsigned char tv1_1[] = "baaaaaaaaaaaaaaa"
                          "aaaaaaaaaaaaaaaa";
  unsigned char tv1_2[] = "bbbbbbbbbbbbbbbb"
                          "bbbbbbbbbbbbbbbb";
  
  printf("diff: %d\n", fitness(tv1_1, tv1_2, 32));
  
  return EXIT_SUCCESS;
}
