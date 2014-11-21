// $Id: newstat.c,v 2.10 2004/05/28 19:22:02 o Exp $
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

#define DBSPECS "dbspecs0" DB ".h"

#include DBSPECS

#define SIZELOG	   16
#define BIG_NUMBER 1000000
#define THRESHOLD  10

#ifdef ID64
typedef long long idtype; 
#else
typedef unsigned long idtype;
#endif


struct stat_st
   {
      idtype n;	/* number */
      long c;	/* count */
   };

struct hit_st
   {
      long i[FIELDS];
   };

	
typedef struct stat_st stat;
typedef struct hit_st hit;

unsigned char	lens[] = BITLENGTHS; 
unsigned char	negs[] = NEGATIVES;
char		deps[] = DEPENDENCIES;

int  readhit ( char *s, hit *h )
   {
      char *t;
      int   i;

      t = s;

      for ( i = 0; i < FIELDS; i++ )
	 {
	    h->i[i] = atol ( t );
	    t = index(t, ' ') + 1;
	 }
   }

idtype getid ( hit *l )
   {
      int  c;
      idtype m = 1;
      idtype ret = 0;

      c = FIELDS;

      while ( c-- )
	 {
	    ret += l->i[c] * m;
	    m *= (lens[c] + 1);
	 }

      return ret;
   }

void unpackid ( idtype id, hit *l )
   {

      idtype n, m = 1;
      int  i;

      n = id;

      for ( i = 1; i < FIELDS; i++ )
	m *= (lens[i] + 1);

      for ( i = 0; i < FIELDS - 1; i++ )
	 {
	    l->i[i] = n / m;

	    n %= m;
	    m /= (lens[i+1] + 1);
	 }

      l->i[FIELDS - 1] = n / m;
   }

int bfind ( stat *a, idtype id, int len )
   {
      int n = 0;
      int i, j, l, c;

      if ( a[0].n >= id ) return 0;
      if ( a[len-1].n == id ) return len - 1;
      if ( a[len-1].n < id ) return len;

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
/*
	    putc ('.', stderr);
 */
	 }
/*
      fprintf (stderr, "ok\n");
 */

      return j;
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

void   lcheck( hit *m )
   {
      int i;

      for ( i = 0; i < FIELDS; i++ )
	m->i[i] = m->i[i]%4 ? 4 * (m->i[i]/4 + 1) > lens[i] ? lens[i] : 4 * 
(m->i[i]/4 + 1) : m->i[i];
      
   }

void   addhit ( stat *a, stat *b, int *len, hit *l, int c )
   {
      idtype w, id;

      id = getid ( l );

      if ( !*len ) 
	 { 
	    a[0].n = id; 
	    a[0].c = c; 

	    (*len)++; 
	 }
      else 
         {
	    w = bfind (a, id, *len);
/*fprintf (stderr, "%d\n", w);*/
	    if ( w == *len )
	       {
		  a[w].n = id;
		  a[w].c = c;

		  (*len)++;
	       }

	    else if ( a[w].n == id ) a[w].c += c;

	    else 
	       {
		  memcpy ((char *)b, (char *)a + w * sizeof(stat), (*len - w) * sizeof(stat));
		  a[w].n = id;
		  a[w].c = c;

		  memcpy ((char *)a + (w + 1) * sizeof(stat), (char *)b, (*len - w) * sizeof(stat)); 

		  (*len)++;
	       }
	 }
   }

int main ()
   {
      stat   *a,*b,*c;
      hit     h,l;
      int     p[FIELDS];
      char    str[256], str_last[256];
      char   *s;

      int     i, j, len = 0, nlen = 0;
      int     enough, sizelog = SIZELOG;
      idtype id;

      a = (stat *) malloc ( sizeof (stat) * 1 << sizelog );
      b = (stat *) malloc ( sizeof (stat) * 1 << sizelog );
      c = (stat *) malloc ( sizeof (stat) * 1 << sizelog );

      while ( gets (str) )
	 {
	    s = index (str, ' ') + 1;
	    
	    str [ s - str - 1 ] = '\0';

	    readhit (s, &h); 

	    if ( strcmp (str, str_last) )
               {
                  strcpy ( str_last, str );
/*
                  p[0] = BIG_NUMBER;  
 */               
		  for ( i = 0; i < FIELDS; i++ ) 
		    l.i[i] = log2 (h.i[i] + negs[i]);
               }
	    else
	       {

		  l.i[0] = h.i[0] == p[0] ? 0 : log2 (h.i[0] - p[0]);
		  i = 1;
/*

		  i = 0; 
 */		  
		  while ( i < FIELDS )
 		    {
/*
		      enough = 0;
 */
                      enough = h.i[0] != p[0];
		      j = 0;

		      while ( !enough )
			{
			  if (h.i[i] != p[i]) enough++;
			  l.i[i] = enough ? log2 (h.i[i] - p[i]) : 0;
			  j = i;
			  i++;
/*putc('.',stderr);*/
			}

		      while ( i < FIELDS && ( deps[i] == j ) )
			{
			  l.i[i] = log2 (h.i[i] + negs[i]);
			  j = i;
			  i++;
/*putc('+',stderr);*/
			}
		    }
		}
/*putc('\n',stderr);*/
	    for ( i = 0; i < FIELDS; i++ ) p[i] = h.i[i];
				 
	    addhit (a, b, &len, &l, 1);

/*fprintf (stderr, "%d\n", len);*/

	    if ( len == (1 << sizelog) )
	      {
		fprintf (stderr, "\ngarbage collecting... ");

		nlen = 0;

		for ( i = 0; i < len; i++ )
		  {
		    unpackid (a[i].n, &l);

		    if ( a[i].c < THRESHOLD ) lcheck (&l);

		    addhit (b, c, &nlen, &l, a[i].c);
		  }

		free (a);
		a = b;
		b = (stat *) malloc ( sizeof (stat) * 1 << 16 );
		len = nlen;

		fprintf (stderr, "%d significant nodes\n", len);
	      }

	  }


      for ( i = 0; i < len; i++ )
	 {
	    unpackid (a[i].n, &l);

	    for ( j = 0; j < FIELDS; j++ )
	       printf ("%d ", l.i[j]);

	    printf ("%d\n", a[i].c);
	 }

      for ( j = 0; j < FIELDS; j++ )
	printf ("0 ");

      return 0;
}

