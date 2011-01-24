;  File:      libimg_sse.asm
;  Date:      23.01.2011
;  Author:    <Radek Fer> xferra00@stud.fit.vutbr.cz
;  Project:   libimg_sse
;  Description: Useful quick (SSE accelerated) functions for image processing
;
;  Copyright (C) 2002 Radek Fer
;
;  This program is free software; you can redistribute it and/or
;  modify it under the terms of the GNU General Public License as
;  published by the Free Software Foundation; either version 2 of the
;  License, or (at your option) any later version.
;
;  This program is distributed in the hope that it will be useful, but
;  WITHOUT ANY WARRANTY; without even the implied warranty of
;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;  General Public License for more details.
;
;  You should have received a copy of the GNU General Public License
;  in a file called COPYING along with this program; if not, write to
;  the Free Software Foundation, Inc., 675 Mass Ave, Cambridge, MA
;  02139, USA.
%include "defines.mac"

[section .text]
  global absdiff


%ifidn __OUTPUT_FORMAT__, elf32
;=============================================================================
; unsigned int absdiff( uint_8 *img1, uint_8 *img2, unsigned int length );
; >> img1: ebp+8 | img2: ebp+12 | len: ebp+16
; =============================================================================
absdiff:
  push ebp
  mov ebp, esp
  backup_regs

  mov ecx, [ebp+16]
  and ecx, 0xFFFFFFF0     ; ecx div 16 - ptr
  shr ecx, 4  ; number of bytes -> nuber of blocks (counter)

  mov esi, [ebp+8]
  mov edi, [ebp+12]

  xor eax, eax  ; sum of all differences for all blocks

main_loop32:
  ; load block
  movups xmm0, [esi]
  movups xmm1, [edi]
  add esi, 16
  add edi, 16

  ; count absolute difference of all B in block
  psadbw xmm1, xmm0   ; xmm1 = [ sumofdiffs hi | sumofdiffs lo ]
  movhlps xmm0, xmm1  ; xmm0 = [  unchanged    | sumofdiffs hi ]
  paddd xmm0, xmm1    ; xmm0 = [  not needed   |    result     ]

  movd edx, xmm0
  add eax, edx
loop main_loop32

  ; do rest - TODO


  restore_regs
  mov esp, ebp
  pop ebp
  ret

%elifidn __OUTPUT_FORMAT__, elf64
;=============================================================================
; unsigned int absdiff( uint_8 *img1, uint_8 *img2, unsigned int length );
; >> img1: rdi | img2: rsi | len: rdx
; =============================================================================
absdiff:
  mov rcx, rdx   ; move to "ecx" 3. parameter
  and ecx, 0xFFFFFFF0     ; ecx div 16 - ptr
  shr ecx, 4  ; number of bytes -> nuber of blocks (counter)

  xor rax, rax  ; sum of all differences for all blocks

main_loop64:
  ; load block
  movups xmm1, [rdi]
  movups xmm0, [rsi]
  add rsi, 16
  add rdi, 16

  ; count absolute difference of all B in block
  psadbw xmm1, xmm0   ; xmm1 = [ sumofdiffs hi | sumofdiffs lo ]
  movhlps xmm0, xmm1  ; xmm0 = [  unchanged    | sumofdiffs hi ]
  paddd xmm0, xmm1    ; xmm0 = [  not needed   |    result     ]

  movq rdx, xmm0
  add rax, rdx
loop main_loop64

  ; do rest - TODO

  ; return eax
  ret

%else
%error "Output format (-f) must be elf32 or elf64!"
%endif
