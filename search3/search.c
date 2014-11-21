// $Id: search.c,v 2.11 2004/05/28 19:22:06 o Exp $
// philologic 2.8 -- TEI XML/SGML Full-text database engine
// Copyright (C) 2004 University of Chicago
// 
// This program is free software; you can redistribute it and/or modify
// it under the terms of the Affero General Public License as published by
// Affero, Inc.; either version 1 of the License, or\ (at your option)
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

#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <dlfcn.h>

#include "search.h"
#include "out.h"

#include "retreive.h"

Search new_searchObject ( Z8 *tok )
{
  Search s; 
  Z32 plugin = -1; 

  Z32 j; 

  void *p;
  void *(*gp) (void);
  Z8  filename[256];

  if ( (s = (Search) malloc ( sizeof(Search_) )) == NULL )
    return NULL;

  s->depth       = MAXBATCHES;
  s->depth_r     = 0; 

  s->batches     = (Batch) malloc ( sizeof(Batch_) * MAXBATCHES ); 

  if ( tok ) 
    {
      for ( j = 0; dbPlugins[j].dbp_tag; j++ )
	{
	  if ( ! strcmp ( dbPlugins[j].dbp_tag, tok ) )
	    {
	      /*
		ok, we found the function to process
		options for this kind of search,
		i.e. the rest of the command-line
		argument: 
	      */
	      plugin = j; 
	    }
	}
    }
  else
    plugin = 0; 

  /* 
     if there's no builtin plugin that matches the
     tag supplied, let's see if a loadable one
     is available; 
  */

  if ( plugin < 0 )
    {
      /*sprintf ( filename, "/home/leonid/wrk/artfl/new/%s.so", tok );*/

      sprintf ( filename, "%s.so", tok );

      if ((p = dlopen(filename, RTLD_LAZY)) != NULL)
	{
	  if ((gp = dlsym(p, "get_plugin")) != NULL)
	    {
	      dbPlugin *dbp;
	      dbp = gp(); 
	      
	      dbPlugins[j].dbp = dbp; 
	      
	      plugin = j; 
	    }
	}
    }
  
  
  s->hit_def      = dbPlugins[plugin].dbp->create_hitdef ( MAXBATCHES ); 

  s->bn          = 0; 

  s->bincorpus   = 1;
  s->corpus      = NULL;

  s->map         = NULL;

  s->debug       = 0; 

  s->print_limit = DEFAULT_PRINT_LIMIT; 
  s->batch_limit = DEFAULT_BATCH_LIMIT; 
  s->n_printed   = 0;

  s->soft_limit  = 0;

  s->exitcode    = 0;

  return s; 
} 

void assign_boolean_op ( Search s, Z32 level, Z32 op )
{
  Z32 i; 
  /*
  for ( i = 0; i < s->depth; i++ )
    if ( s->hit_def->levels[i].n_real == level )
      {
	s->batches[i].not_op = op; 
	break; 
      }
  */

  s->batches[level].not_op = op;
}



Z32 search_engine_args ( Search s, Z8 *arg )
{
  Z8 *c = arg; 
  Z8 *p;

  Z8  tok[512];

  Z32 i;
  Z32 j = 0;

  while ( *c )
    {
      if ( p = (Z8 *)index ( c, ':' ) )
	{
	  strncpy ( tok, c, p - c ); 
	  tok[p - c] = '\000';
	  c += (p - c) + 1; 
	}
      else
	{
	  strcpy ( tok, c ); 
	  *c = '\000';
	}

      switch ( tok[0] ) 
	{
	case 'd':   /* debugging output level */
	  s->debug = atol (tok+2);
	  s_log (s->debug, L_INFO, "set debug level to %d", (Z8 *)s->debug);
	  break;

	case 'L':   /* print Limit */
	  s->print_limit = atol (tok+2);
	  break; 

	case 'l':   /* batch limit */
	  s->batch_limit = atol (tok+2); 
	  break; 

	case 'N':   /* Number of search levels (deprecated) */
	  s->depth = atol (tok+2);
	  break;

	case 's':   /* "soft" batch limit */
	  s->soft_limit = atol (tok+2);
	  break;

	case 'B':   /* boolean search */
	  for ( i=2; i < strlen ( tok ); i++ )
	    if (tok[i] == '0')
	      assign_boolean_op ( s, i-2, 1 ); 
	    else if (tok[i] == '1')
	      {
		assign_boolean_op ( s, i-2, 0 ); 
		j++;
	      }
	    else
	      {
		strcpy ( s->errstr, "illegal boolean operator" );
		return -1;
	      }

	  if ( i != s->depth + 2 )
	    {
	      strcpy ( s->errstr, "wrong number of boolean operators" );
	      return -1; 
	    }
	  if ( !j )
	    {
	      strcpy ( s->errstr, "at least 1 boolean operator must be '1'!" );
	      return -1; 
	    }
	  else
	    s->depth_r = j; 

	  /*
	  if ( j != s->depth )
	    rearrange_batches ( s ); 
	  */

	  break; 
	    
	}
    }

  return 0;
}

/* a perfectly redundant function: :) */
/* well, it used to be perfectly redundant, but it is
   actually here where we want to check if the batch is
   finished.; Arguably, the blockmap manipulations
   (sorting and/or incrementing the blockmap pointer)
   should also be done here and not in retreive.c;*/

Z32 produce_hits ( Search s, N32 level, Gmap map, Gmap res )
{
  Z32 code_retreive;

  s_log ( s->debug, L_INFO, NULL, "attempting to retreive hits..." ); 

  code_retreive = retreive_hits ( s, level, map, res );

  s_log ( s->debug, L_INFO, "done (code %d returned);", (Z8 *)code_retreive );

  if ( code_retreive & RETR_BUMMER )
    {
      s_log ( s->debug, L_ERROR, NULL, "produce_hits: retreive_hits failed" );
      return SEARCH_BUMMER_OCCURED;
    }

  if ( s->batches[level].blkmapctr >= s->batches[level].blockmap_l )
    {
      s_log ( s->debug, L_INFO, NULL, "produce_hits: end of BLOCK MAP reached; returning.");
      return SEARCH_BATCH_FINISHED;
    }

  if ( code_retreive & RETR_END_OF_MAP )
    {
      s_log ( s->debug, L_INFO, NULL, "produce_hits: end of SEARCH MAP reached; returning.");
      return SEARCH_PASS_FINISHED;
    }

  if ( code_retreive & RETR_RESMAP_FULL )
    {
      s_log ( s->debug, L_INFO, NULL, "produce_hits: batch limit exceeeded; returning.");
      return SEARCH_BATCH_LIMIT_REACHED;
    }

  if ( code_retreive & SEARCH_PRINT_LIMIT_REACHED )
    {
      return SEARCH_PRINT_LIMIT_REACHED;
      s_log ( s->debug, L_INFO, NULL, "produce_hits: print limit reached; returning");
    }

  s_log ( s->debug, L_INFO, NULL, "produce_hits: hits produced; returning.");

  return SEARCH_PASS_OK; 

} 

Gmap map_store_tail ( Search s, N32 level, Gmap r )
{
  Gmap     new = NULL; 

  Batch      B = &s->batches[level];
  blockMap   b = &B->blockmap[B->blkmapctr];
  Word       w = b->w; 
  N32        n = b->n; 

  Z32 *nexthit; 
  N32        c; 
  Z32 *map_ptr; 

  Z32  new_len = 0; 

  Z8   logmesg[256];

  s_log ( s->debug, L_INFO, "entering store_tail; blockmapctr=%d",(Z8 *)B->blkmapctr );

  sprintf ( logmesg, "n_cached=%d", w->n_cached );

  s_log ( s->debug, L_INFO, NULL, logmesg );

  nexthit = w->n_cached ? (Z32 *)w->cached : gm_get_pos ( w->dir, n );
  c = r->gm_eod - 1;

  s_log ( s->debug, L_INFO, "entering store_tail; counter set to %d",(Z8 *)c );
 
  map_ptr = gm_get_pos ( r, c );

  s_log ( s->debug, L_INFO, "\"next hit\" is in doc %d;", (Z8 *)*nexthit );
  s_log ( s->debug, L_INFO, "map_ptr points to hit in %d;", (Z8 *)*map_ptr );

  if ( s->hit_def->levels[level].cntxt_cmp_func == NULL ) 
    s_log ( s->debug, L_ERROR, NULL, "uninitialized context comp. function!" );

  while ( s->hit_def->levels[level].cntxt_cmp_func ( map_ptr, nexthit, s->hit_def, level) >= 0 )
  {
    s_log ( s->debug, L_INFO, NULL, "reducing the map counter by 1;" );
    c--; 
    map_ptr = gm_get_pos ( r, c ); 
  }

  s_log ( s->debug, L_INFO, "%d hits left on the map;", (Z8 *)(c+1) ); 
 
  if ( r->gm_eod - c - 1 )
    {

      s_log ( s->debug, L_INFO, "creating new map to store %d hits;", (Z8 *)(r->gm_eod - c - 1) ); 

      new_len = MAP_INIT_LEN;

      while ( r->gm_eod - c - 1 > new_len )
	new_len *= 2; 

      s_log ( s->debug, L_INFO, "length of the new map is %d;", (Z8 *)new_len ); 

      new = new_Gmap ( new_len, r->gm_f ); 

      memcpy ( new->gm_h, gm_get_pos(r,c+1), sizeof(Z32)*(r->gm_eod-c-1)*new->gm_f );
      gm_set_eod ( new, r->gm_eod - c - 1); 

      r->gm_h = (Z32 *)realloc (r->gm_h, (c + 1) * sizeof(Z32) * r->gm_f); 
      r->gm_l = c + 1; 
      gm_set_eod ( r, c + 1 );
    }
  else
    s_log ( s->debug, L_INFO, NULL, "returning NULL map" ); 

  return new;
}

Z32 resmap_sort_func ( const void *a1, const void *a2)
{
  static Search s = NULL; 
  hitcmp h; 

  Gmap tmp;
 
  if ( a1 == NULL )
    /* initialization: */
    s = (Search)a2;
  else
    {
      if ( !s )
	s_log ( L_ERROR, L_ERROR, "%s", "uninitialized map comparison function run attempted" ); 

      h = s->hit_def->levels[s->bn];
      /* return s->hit_def->levels[s->bn].m2m_cmp_func ((Z32 *)a1, (Z32 *)a2, s->hit_def, s->bn); */
      return h.m2m_cmp_func ((Z32 *)a1, (Z32 *)a2, s->hit_def, s->bn);
    }
}

void sort_result_map ( Search s, Gmap m )
{
  /* first, initialize the search function: */
  
  resmap_sort_func ( NULL, (const void *)s ); 

  /* now we can use it to sort the results: */

  s_log ( s->debug, L_INFO, "attempting to sort a map of length %d;", (Z8 *)m->gm_eod ); 

  qsort ( m->gm_h, m->gm_eod, sizeof(Z32)*(m->gm_f), resmap_sort_func ); 

  s_log ( s->debug, L_INFO, NULL, "(sorted)" ); 
}

/* this one does most of the work for us: */

N32 search_pass ( Search s, N32 bn ) 
{

  Gmap map = s->batches[bn].map;

  Z32   rmf; /* results map factor */

  Z32  code;
  Z32  code_nl; 

  s_log ( s->debug, L_INFO, "entering search pass, level %d", (Z8 *)bn ); 

  /* 
     let's create a map for the search results:
   */

  if ( s->batches[bn].not_op )
    {
      if ( ! map )
	{
	  /* not supposed to happen! */
	  /* print an error message here... */
	}

      rmf = map->gm_f; 
    }
  else
    {
      if ( s->hit_def->levels[bn].hitsize_func == NULL )
	fprintf ( stderr, "BIG FAT WARNING!! uninitialized hitsize_func;\n" ); 

      rmf = s->hit_def->levels[bn].hitsize_func(s->hit_def, bn);
    }

  s_log ( s->debug, L_INFO, "initializing results map... (factor %d)", (Z8 *)rmf ); 

  s->batches[bn].res = new_Gmap ( MAP_INIT_LEN, rmf ); 

  s_log ( s->debug, L_INFO, "initialized results map; (factor %d)", (Z8 *)rmf ); 

  /* OK, here's the logic of what's going on here: 
     
     First, we search for hits on the current level,
     moving along the blockmap as we go (one block unit
     at a time that is); we are going as far as we can
     -- until we complete the search on the current
     level (in the boundaries of the current search
     Map), OR get too many hits on the Result map: */

  while (( code = produce_hits ( s, bn, map, s->batches[bn].res )) != SEARCH_BUMMER_OCCURED )
    {
      s_log ( s->debug, L_INFO, "produce_hits returned %d", (Z8 *)code ); 

      if ( code == SEARCH_PASS_OK )
	{/* just keep retreiving... */
	  s_log ( s->debug, L_INFO, NULL, "continuing into next block" ); 
	}

      else
	{

  /* more interesting stuff begins... this is one of
     the 2 possible cases described above; but for now
     we don't even care if we have completed the
     search, or exceeded the results limit; our primary
     concern is what to do with all the hits we have
     found: */

  /*
     If this is the last level, then the hits on the
     Result map are the final results and can be
     printed, so we can simply dump them out (though
     we have to watch for the Print Limit)
  */
     
  /*
     If this is not the last level, we have to run
     the next level search using the results of the
     search we've just completed ourselves (Result map)
     as the Search Map for the next level search.

     in any event, we sort the map first:
  */
	  
	  if ( s->batches[bn].howmany > 1 )
	    {
	      s_log ( s->debug, L_INFO, NULL, "sorting results map;" );
	      sort_result_map ( s, s->batches[bn].res );
	    }
	  else
	    s_log ( s->debug, L_INFO, NULL, "processing results w/out sorting;" ); 
	      
  
  /* HOWEVER, */

  /* before we can do either of the above, some map
     magic has to be performed.  We cannot use the
     *entire* result map as the Search map for the next
     level search and neither can we print this map out
     as the search result if this is the bottom level;
     because we might still have hits on this level, in
     the unprocessed portion of our blockmap, that
     occur in the same <CONTEXT> objects as the hits in
     the tail of the present result map. So if these
     results get dumped out we can't guarantee that all
     the results are sorted properly; if we use these
     results as the search map, we are likely to lose
     some cooccurences. so we have to chop this tail
     off and save it for the next iteration (assuming,
     of course, we haven't reached the end of blockmap
     yet).

  */
      	  if ( s->batches[bn].howmany > 1 && ( bn < s->depth - 1 ) && ( code != SEARCH_BATCH_FINISHED ) )
	    {
	      s_log ( s->debug, L_INFO, NULL, "attempting to store res map tail;");
	      s->batches[bn].stored = map_store_tail ( s, bn, s->batches[bn].res );
	    }

	  if ( s->batches[bn].stored )
	    s_log ( s->debug, L_INFO, "done; (%d hits stored)", (Z8 *)s->batches[bn].stored->gm_eod ); 
	  else
	    s_log ( s->debug, L_INFO, NULL, "proceeding with the res. map intact" ); 
	  gm_set_pos ( s->batches[bn].res, 0 ); 
	  /*gm_rewind ( res );*/

	  s_log ( s->debug, L_INFO, "result map position set to %d", (Z8 *)s->batches[bn].res->gm_c ); 
	  s_log ( s->debug, L_INFO, "%d hits on the result map", (Z8 *)s->batches[bn].res->gm_eod ); 

	  if ( s->batches[bn].res->gm_eod )
	    {

	      if ( bn == s->depth - 1 )
		{
		  s_log ( s->debug, L_INFO, NULL, "attempting to dump hits out" );
		  code_nl = dump_hits_out ( s, bn, s->batches[bn].res ); 
		  old_Gmap ( s->batches[bn].res ); 
		  s_log ( s->debug, L_INFO, NULL, "hits printed; returning." );
		}
	      else
		{
		  /* we run the next level search; */

		  s->batches[bn + 1].map = s->batches[bn].res; 

		  /* the results ("hits") found in the next
		     iteration are going to be larger than
		     in the current one; because some parts
		     of the indices found in the next
		     iteration are going to be appended to
		     the hits found while searching the
		     current batch;
		     since we ("the search engine") don't really
		     know anything about the structure of our
		     "hits", let's ask someone who knows:
		   */


		  /* 
		     let's run it! When it returns, we are
		     guaranteed that everything that was
		     there to be found on the lower levels 
		     has been found; it might've taken them
		     a godzillion iterations, but we don't
		     really care: 
		  */

		  code_nl = search_pass ( s, bn + 1 ); 

		  old_Gmap ( s->batches[bn].res ); 
		  
		}

	      if ( code_nl == SEARCH_BUMMER_OCCURED ) 
		return SEARCH_BUMMER_OCCURED;

	      /* if <PRINT_LIMIT> hits have been printed,
		 there's nothing left for us to do: */

	      if ( code_nl == SEARCH_PRINT_LIMIT_REACHED ) 
		return SEARCH_PRINT_LIMIT_REACHED;
	    }

	  /* 
	     we can continue searching; 
	     (if there's anything left on the blockmap, that is)
	   */


	  if ( code == SEARCH_PASS_FINISHED || code == SEARCH_BATCH_FINISHED ) 
	    {
	      s_log ( s->debug, L_INFO, NULL, "this level is finished; returning.");
	      return SEARCH_PASS_FINISHED;
	    }
	  


	  /*
	    and not forget about the hits we cached
	    before we ran the lower-level search:
	  */
	      
	      
	  if ( s->batches[bn].stored )
	    {
	      s_log ( s->debug, L_INFO, "found stored results (%d hits)", (Z8 *)s->batches[bn].stored->gm_eod ); 

	      s->batches[bn].res = s->batches[bn].stored;
	      s->batches[bn].stored = NULL;
	    }
	  else 
	    {
	      s->batches[bn].res = new_Gmap ( MAP_INIT_LEN, rmf ); 
	      s_log ( s->debug, L_INFO, "initialized results map, again; (factor %d)", (Z8 *)rmf ); 
	    }
	}
    }

  /* we should never really get here, should we? */
  /* unless some kinda bummer occured: */

  return SEARCH_BUMMER_OCCURED;
}






