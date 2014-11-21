// $Id: idtest.c,v 2.10 2004/05/28 19:22:02 o Exp $
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

#define  ULTEST 0x100000000

typedef long long myidtype;

unsigned char	lens[] = BITLENGTHS; 

myidtype idtest ()
   {
      int  c;
      myidtype m = 1;
      myidtype ret = 0;

      c = FIELDS;

      while ( c-- )
	 {
	    ret += lens[c] * m;
	    m *= (lens[c] + 1);
	 }

      return ret;
   }

int main ()
   {

     if ( idtest() < ULTEST )
       printf ( "ID32\n" ); 
     else
       printf ( "ID64\n" ); 
     
     return 0; 

   }















