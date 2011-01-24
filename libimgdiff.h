/* File:      libimgdiff.h
   Date:      23.01.2011 23:11
   Author:    <Radek Fer> xferra00@stud.fit.vutbr.cz
   Project:   libimgdiff
   Description: Useful quick (SSE accelerated) functions for image processing

   Copyright (C) 2002 Radek Fer

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
#ifndef __LIBIMGDIFF_H__
#define __LIBIMGDIFF_H__

/* compute sum of absolute differences for corresponding bytes in 2 arrays
 * given by pointers $img1 and $img2, both with same lenght $lenght
 */
unsigned int fitness(unsigned char *img1, unsigned char *img2,
                 unsigned int length)__attribute((cdecl));

#endif

