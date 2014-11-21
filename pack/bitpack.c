// $Id: bitpack.c,v 2.10 2004/05/28 19:22:02 o Exp $
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

#include "c.h"
#include "bitpack.h"

N8             word_length;
N64	       word_code;
N64	       code_buffer=0;
N32	       byte_counter=0;

N8             bytes_to_load=8;
N8             free_space=64;

/*char           val_buffer[BUFFERSIZE];*/

N8 	       lens[] = BITLENGTHS;
N8	       negs[] = NEGATIVES;

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


void    encoding()
               {
                         if ( word_length < free_space )
                           {
                               code_buffer |= ( word_code << 64 - free_space );
                               free_space -= word_length;
                           }
                         else if ( word_length > free_space )
                           {
                               code_buffer |= ( word_code << 64 - free_space );
			       word_code >>= free_space;
                               word_length -= free_space;
			       
                                  load();

                               code_buffer |= word_code;
                               free_space -= word_length;
                           }
                         else if ( word_length == free_space )
                           {
                               code_buffer |= ( word_code << 64 - free_space );
                               load();
                           }
                 }


void        load()
               {
                 int i;

                  for (i = 0; i < bytes_to_load; i++)
                      val_buffer [byte_counter + i] = (char) (code_buffer>>(8*i));

                  free_space  = 64;
                  code_buffer = 0;

                  byte_counter += bytes_to_load;
               }








