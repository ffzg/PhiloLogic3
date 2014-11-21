// $Id: filtt1.c,v 2.10 2004/05/28 19:22:02 o Exp $
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

typedef char  conc_type[512];

conc_type buffer[16];

char str[512], str_last[512];

char *cntrl_str="%%%";

int  counter,flag=0;

int  i;

void main()
     {

       while (!flag)
           {
              if ( !gets (str) )
                 flag++;

              if ( strncmp(str, str_last, index (str, ' ') - str ) || flag ) 
                { 
                    if (counter)
                    printf("%s %d\n", cntrl_str, counter);

                    for ( i=0; i<counter; i++ ) printf ("%s\n", buffer[i]); 

		    strcpy(str_last,str);
		    counter=0;
                }

	      strcpy (buffer[counter], str); 
           
	      counter++;
           }
      exit(0);
   }        
