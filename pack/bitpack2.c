// $Id: bitpack2.c,v 2.10 2004/05/28 19:22:02 o Exp $
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

#define DBSPECS "dbspecs1" DB ".h" 
#include DBSPECS

#include "bitpack2.h"


hit	       m, i, l;
huff	      *a;

N32            word_length;
N32	       word_code;
N32	       code_buffer=0;
N32	       word_counter=0;

N8             free_space=32;

char           val_buffer[512];

N8 lens[] = BITLENGTHS;
N8 negs[] = NEGATIVES;
Z8 deps[] = DEPENDENCIES;

void   load()         
       {           
           int i;

           if ( word_counter < BLK_SIZE/4 )
	     for ( i=0; i<4; i++ ) printf ("%c", code_buffer >> (8*i));

           free_space  = 32;
           code_buffer = 0;

           word_counter++;
       }


Z32  Encoding( hit *m, hit *i )
   {
      NXX id;
      N32 j,n;
      
      id = getid ( m );
      n = bfind (a, id, TABLESIZE);

      word_length = a[n].l;
      word_code  =  a[n].c;

      encoding();

      for ( j = 0; j < FIELDS; j++ )
 	 {	
	    if ( m->i[j] )
	       {
		  word_length = m->i[j]; 
		  word_code = i->i[j] + negs[j];
	    
		  encoding();
	       }
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


void   lcheck( hit *m )
   {
      NXX id;
      Z32 i,n;

      id = getid ( m );
      n = bfind ( a, id, TABLESIZE );
      
      if ( n == NOTFOUND )
	 for ( i = 0; i < FIELDS; i++ )
	    m->i[i] = m->i[i]%4 ? 4 * (m->i[i]/4 + 1) > lens[i] ? lens[i] : 4 * (m->i[i]/4 + 1) : m->i[i];
      
      id = getid ( m );
      n = bfind ( a, id, TABLESIZE );

      if ( n == NOTFOUND )
/*
   Well, if we still didn't get it...
 */
	 {
	    fprintf (stderr, "no tree entry for");

	    for ( i = 0; i < FIELDS; i++ )
	       fprintf (stderr, " %d", m->i[i]);
	    fprintf (stderr, "\n");

	    fprintf (stderr, "this is NOT supposed to happen!\n");

	    exit (1);
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

NXX getid ( hit *l )
   {
      N32  c;
      NXX  m = 1;
      NXX  ret = 0;

      c = FIELDS;

      while ( c-- )
	 {
	    ret += l->i[c] * m;
	    m *= (lens[c] + 1);
	 }

      return ret;
   }

Z32 bfind ( huff *a, NXX id, N32 len )
   {
      N32 n = 0;
      Z32 i, j, l, c;

      if ( a[0].n == id ) return 0;
      if ( a[len-1].n == id ) return len - 1;

      i = 0;
      l = j = len - 1;

      while ( l > 1 )
	 {
	    c = i + (j - i)/2;

	    if (a[c].n == id) return c;

	    else if (a[c].n < id) 
	       i = c;

	    else j = c;

	    l = j - i;
	 }

      return NOTFOUND;
   }


Z32         transform( bit )
            char  bit;

               {
                  if (bit=='1') return (1);
                  else if (bit=='0') return (0);
               }
/*
   Nice code, dude. ;)
 */

Z32         log2(number)
            int number;
            {
              int log;

              log=0;
              if (number==0) return(1);
              while (number!=0)
                   {
                     number/=2;
                     log++;
                   }
              return(log);
            }

 



