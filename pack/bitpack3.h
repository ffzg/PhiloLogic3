// $Id: bitpack3.h,v 2.10 2004/05/28 19:22:02 o Exp $
// philologic 2.8 -- TEI XML/SGML Full-text database engine
// Copyright (C) 2004 University of Chicago
// 
// This program is free software; you can redistribute it and/or modify
// it under the terms of the Affero General Public License as published by
// Affero, Inc.; either version 1 of the License, or (at your option)
// any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// Affero General Public License for more details.
// 
// You should have received a copy of the Affero General Public License
// along with this program; if not, write to Affero, Inc.,
// 510 Third Street, Suite 225, San Francisco, CA 94107 USA.

#define   LINESIZE	1024
#define	  NOTFOUND	-1

struct hit_st
{
  long i[FIELDS];
};

typedef struct hit_st hit;

extern hit  l,m;

extern N8   lens[];
extern N8   negs[];

extern void load();
extern Z32  Encoding();
extern Z32  endsymbol_out(); 

extern void encoding();
extern void readhit();

extern  N32	 word_length;
extern  N32      word_code;
extern  N32      code_buffer;

extern  N32      word_counter;

extern  N8       free_space;





