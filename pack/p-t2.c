// $Id: p-t2.c,v 2.10 2004/05/28 19:22:02 o Exp $
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

#define  TYPE2  1


char *GUIDEFILE = "conc.guide";
char *DIRFILE  =  "conc.dir";

FILE *fp2, *fp3, *fp4;

 
N32      blkn;
N32      tot_fr;
N64      offst;

Z32      i;

char     *val_buffer;

char str[LINESIZE];
char hstr[LINESIZE];

void Encoding ( hit *i )
   {
      Z32 j;

      for ( j = 0; j < FIELDS; j++ )
	 {
	    word_length = lens[j]; 
	    word_code = i->i[j];
	    
	    encoding();
	 }
   }


void main()
   {

      datum     key,value;
      GDBM_FILE index_dbm;

      hit 	l;
      N32       buf_size, fixed = 0;

        
      key.dptr = &(str[0]);

      if((index_dbm = gdbm_open("index",4096, GDBM_WRCREAT, 0644, 0)) == NULL)
          {
              fprintf(stderr,"Can't open gdbm file!\n");
              exit(1);
          }


      fp2 = fopen(GUIDEFILE,"r");
      fp4 = fopen(DIRFILE,"r");

      fp3 = fopen("hlpfile","w");
      setbuf (fp3, NULL);

      for ( i = 0; i < FIELDS; i++ )
	fixed += lens[i];
	 
/*
   The last file is for merely statistical info; I'm logging the sizes of 
   gdbm entries for all words being stored, for future analysis and research. 
   It is not used for any functional purposes.
 */
 

      while( fscanf ( fp2, "%s %llu %u %u\n", 
		      str, &offst, &tot_fr, &blkn ) != EOF )
          {

	      free ( val_buffer );

	      buf_size = ( blkn * fixed + TYPE_LENGTH 
                         + FREQ2_LENGTH + OFFST_LENGTH
			 ) / 8 + 1; 

	      val_buffer = (char *) malloc ( buf_size ); 
              value.dptr = &(val_buffer[0]);


              byte_counter = 0;

              word_length = TYPE_LENGTH;
              word_code = TYPE2;

              encoding();

              word_length = FREQ2_LENGTH;
              word_code = tot_fr;

              encoding();

              word_length=OFFST_LENGTH;
              word_code=offst;

              encoding();

              for( i = 0; i < blkn; i++)    
                  {
                      if ( fgets (hstr, LINESIZE, fp4) )
			{
			    readhit (hstr, &l); 
			    Encoding( &l );
			}
		      else
			{      
			    fprintf (stderr, 
			        "synchronization error reading block directory.\n");
			    exit (1);
			}
                  } /* "for" */

               bytes_to_load=(71-free_space)/8;
               load();  
               bytes_to_load=8;


               key.dsize = strlen(str);
               value.dsize =  byte_counter;
               
	       if (gdbm_store(index_dbm,key,value,GDBM_REPLACE) !=0)
                   {
                       fprintf(stderr,"Problem storing gdbm entry for %s.\n",key.dptr);
                       exit(1);
                   }
	      
               fprintf (fp3, "%s %d\n", str, byte_counter);



          }    /* while */


      fclose(fp2);
      fclose(fp3);
      fclose(fp4);

      gdbm_close(index_dbm);         

      exit(0);
        
  }
 


