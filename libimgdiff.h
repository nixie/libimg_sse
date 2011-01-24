/*
   Date:     23.01.2011 23:11
   Author:    <Radek Fer> xferra00@stud.fit.vutbr.cz
   Project:   libbgradiff
   Description: TODO

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
#ifndef __TEST_H__
#define __TEST_H__

unsigned int fitness(unsigned char *img1, unsigned char *img2,
                 unsigned int length)__attribute((cdecl));

#endif

