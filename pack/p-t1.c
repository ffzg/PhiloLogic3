// $Id: p-t1.c,v 2.10 2004/05/28 19:22:02 o Exp $
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
#include <gdbm.h>
#include <fcntl.h>

#include "c.h"
#include "bitpack.h"

#define  TYPE1  0


N32      conc_counter=0;

N16      occ_num;

char     *val_buffer; 

char *cntrl_str="%%%";

void Encoding ( hit *i )
   {
      Z32 j;

      for ( j = 0; j < FIELDS; j++ )
	 {
	    word_length = lens[j]; 
	    word_code = i->i[j] + negs[j];
	    
	    encoding();
	 }
   }




void main()
  {
    datum     key,value;
    GDBM_FILE index_dbm;

    Z32	      local_counter;
    hit	      i;

    Z8 	      str[LINESIZE];
    Z8 	     *s;


    setbuf (stdout, NULL);

    val_buffer = (char *) malloc ( BUFFERSIZE );
        
        key.dptr = &(str[0]);
        value.dptr = &(val_buffer[0]);

        if((index_dbm = gdbm_open("index",4096, GDBM_WRCREAT, 0644,
                  0)) == NULL)
          {
            fprintf(stderr,"Can't open gdbm file!\n");
            exit(1);
          }
  
 
        while ( gets (str) )
          {
	    s = index (str, ' ') + 1;
	    str [ s - str - 1 ] = '\0';

            if ( !strcmp (str, cntrl_str) ) 
              {
                  occ_num = atol (s);
                  byte_counter = 0;
                  conc_counter = 0;

                  word_length = TYPE_LENGTH;
                  word_code = TYPE1;
                  encoding();

                  word_length=FREQ1_LENGTH;
                  word_code=occ_num;
                  encoding();  

              }
            else
              { 
		readhit (s, &i); 

                if(occ_num == conc_counter) 
                  {
                    fprintf(stderr, "Input filter error!\n");
                    exit(1);
                  }

                Encoding ( &i );
                conc_counter++;
                      
                if ( conc_counter == occ_num) 
                   { 
		      bytes_to_load=(71-free_space)/8;
		      load();
		      bytes_to_load=8;


                      key.dsize = strlen(str);
                      value.dsize =  byte_counter;

                      if (gdbm_store(index_dbm,key,value,GDBM_REPLACE) !=0)
                        {
                          fprintf(stderr,"Problem storing dbm entry for %s.\n",key.dptr);
                          exit(1);
                        }

		      local_counter++;

		      if ( !( local_counter % 1000 )) putchar ('+');
		      else if ( !( local_counter % 100 )) putchar ('.');
		  
                                                 
		   }
         

              } /* "else" */


         }    /* while */

      gdbm_close (index_dbm);
      exit(0);        
                      
  }
 







