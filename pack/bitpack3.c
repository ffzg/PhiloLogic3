// $Id: bitpack3.c,v 2.10 2004/05/28 19:22:02 o Exp $
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

#include <stdio.h>

#include "c.h"

#include "dbspecs0c.h" 

#include "bitpack3.h"


hit	       l,m;

N32            word_length;
N32	       word_code;
N32	       code_buffer=0;
N32	       word_counter=0;

N8             free_space=32;

N8 lens[] = BITLENGTHS;
N8 negs[] = NEGATIVES;

void   load()         
{           
  int i;
  
  if ( word_counter < BLK_SIZE/4 )
    for ( i=0; i<4; i++ ) printf ("%c", code_buffer >> (8*i));
  
  free_space  = 32;
  code_buffer = 0;
  
  word_counter++;
}


Z32  Encoding( hit *m )
{
  N32 j;
  
  for ( j = 0; j < FIELDS; j++ )
    {	
      word_length = lens[j]; 
      word_code = m->i[j] + negs[j];
	      
      encoding();
    }

  return ( word_counter + ((free_space%32) ? 1 : 0) > BLK_SIZE/4 );

  /* we return zero on success, that is. */

}

Z32  endsymbol_out ( hit *m )
{
  N32 j;
  
  for ( j = 0; j < FIELDS; j++ )
    {	
      word_length = lens[j]; 
      word_code = (1 << lens[j]) - 1; 
	      
      encoding();
    }

  return ( word_counter + ((free_space%32) ? 1 : 0) > BLK_SIZE/4 );

  /* we return zero on success, that is. */

}

void    encoding()
{
  if ( word_length < free_space )
    {
      code_buffer |= ( word_code << 32 - free_space );
      free_space -= word_length;
    }
  else if ( word_length > free_space )
    {
      code_buffer |= ( word_code << 32 - free_space );
      word_code >>= free_space;
      word_length -= free_space;
			       
      load();

      code_buffer |= word_code;
      free_space -= word_length;
    }
  else if ( word_length == free_space )
    {
      code_buffer |= ( word_code << 32 - free_space );
      load();
    }
}


void  readhit ( Z8 *s, hit *h )
{
  Z8   *t;
  N32   i;

  t = s;

  for ( i = 0; i < FIELDS; i++ )
    {
      h->i[i] = atol ( t );
      t = index(t, ' ') + 1;
    }
  
}




