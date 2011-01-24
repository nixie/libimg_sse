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
#include <string.h>
#include <inttypes.h>
#include "libimgdiff.h"

#define HEIGHT  512
#define WIDTH   512
#define LENGTH  HEIGHT*WIDTH

#define rdtsc() ({ uint64_t x; asm volatile("rdtsc" : "=A" (x)); x; })

unsigned int fitness(unsigned char *img1, unsigned char *img2,
                       unsigned int length);
unsigned int fitness_C(unsigned char *img1, unsigned char *img2,
                       unsigned int length);

int main(int argc, char *argv[])
{ 
  char *img1 = malloc(1*LENGTH);
  char *img2 = malloc(1*LENGTH);
  memset(img1, 0x00, LENGTH);
  memset(img2, 0x01, LENGTH);
   
  uint64_t start_tsc, end_tsc, diff_asm, diff_C;
  unsigned int result_asm, result_C;

  // ASM (SSE2) version
  start_tsc = rdtsc();
  result_asm = fitness(img1, img2, LENGTH);
  end_tsc = rdtsc();
  printf("asm: %d (%qd ticks)\n", result_asm, end_tsc - start_tsc); 

  // C version
  start_tsc = rdtsc();
  result_C = fitness_C(img1, img2, LENGTH);
  end_tsc = rdtsc();
  printf("C  : %d (%qd ticks)\n", result_C, end_tsc - start_tsc); 
  
  return EXIT_SUCCESS;
}

unsigned int fitness_C(unsigned char *img1, unsigned char *img2,
    unsigned int length){
  // for each byte compute absolute difference and add it to sum
  unsigned int sum=0;
  unsigned char byte1, byte2;
  while(length-- != 0){
    byte1 = *(img1++);
    byte2 = *(img2++);
    sum += (byte1>byte2)? byte1-byte2 : byte2-byte1;
  }

  return sum;
}
