// $Id: indstrip.c,v 2.10 2004/05/28 19:22:02 o Exp $
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
#include <strings.h>
#include <memory.h>

#include "dbspecs.H"


struct hit_st
   {
      int i[FIELDS];
   };

typedef struct hit_st hit;

int negs[FIELDS] = NEGATIVES;

int  readhit ( char *s, hit *h )
   {
      char *t;
      int   i;

      t = s;

      for ( i = 0; i < FIELDS; i++ )
	 {
	    h->i[i] = (int) atol ( t );
	    t = index(t, ' ') + 1;
	 }
   }

int log2( int number )
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

int main (int argc, char *argv[])
{
  hit h;
  int max[FIELDS];
  char str[1024];
  char *s;	
  FILE *f;
  int  i;

  for ( i = 0; i < FIELDS; i++ )
    max[i] = 0;

  while ( gets (str) )
    {
      s = index (str, ' ') + 1;

      str [ s - str - 1 ] = '\0';

      readhit (s, &h);

      puts (str);
  
      for ( i = 0; i < FIELDS; i++ )
	if ( h.i[i] > max[i] ) max[i] = h.i[i];

    }

  f = fopen (argv[1], "w");

  fprintf ( f, "{" );

  for ( i = 0; i < FIELDS - 1; i++ )
    {
      fprintf ( f, "%d,", log2(max[i] + negs[i]) );
      fprintf ( stderr, "%d,", max[i] );
    }

  fprintf ( f, "%d}\n", log2(max[i] + negs[i]) );
  fprintf ( stderr, "%d\n", max[i] );

  exit (0);
}






