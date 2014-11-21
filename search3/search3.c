// $Id: search3.c,v 2.11 2004/05/28 19:22:06 o Exp $
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
#include <string.h>
#include "c.h"
#include "search.h"

Z main(Z argc, String *argv)
{ 
  Z status; 
  String basename;

  Search s = new_searchObject( NULL ); 

  /*
    check for the "compatibility mode" -- if callsed as 
    "search_", the default name of the search engine v.2 
    binary, the search engine goes into this mode where
    it understands the same command-line options and
    mimicks the old functionality.
  */

  basename = rindex ( argv[0], '/' );

  if ( basename == NULL )
    basename = argv[0]; 
  else
    basename++; 

  if ( strcmp ( "search_", basename ) )
    status = process_command_argz ( s, argc, argv ); 
  else
    status = process_command_argz_backwardcompat ( s, argc, argv ); 
  
  if ( status ) 
    {
      s_log ( L_ERROR, L_ERROR, "%s", s->errstr );
      return s->exitcode;
    }

  s_log ( s->debug, L_INFO, NULL, "processed command line arguments;" );


  status = process_input ( s, stdin ); 

  if ( status == -1 ) 
    {
      s_log ( s->debug, L_ERROR, "could not read input: %s", s->errstr );
      return s->exitcode;
    }
  else if ( status == BATCH_EMPTY )
    {
      s_log ( s->debug, L_INFO, NULL, "one of the levels empty; returning NULL" ); 
      return 0; 
    }

  s_log ( s->debug, L_INFO, NULL, "processed search input;" );

  /* should not be done here/like this: */

  s->batches->map = s->map; 
  /*s->batches[0].map = s->map; */

  if ( ! s->map )
    s_log ( s->debug, L_INFO, NULL, "no search corpus;" );
  else
    s_log ( s->debug, L_INFO, "first element on the corpus map: %d\n", (Z8 *)s->map->gm_h[0] );

  while ( status = search_pass ( s, 0 ) == SEARCH_PASS_OK ) 
    continue;

  if ( status == SEARCH_BUMMER_OCCURED )
    s_log ( s->debug, L_ERROR, "search could not be completed: %s", s->errstr );

  return s->exitcode; 
}



