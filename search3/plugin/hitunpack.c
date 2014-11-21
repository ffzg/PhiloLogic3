#include "hitdef.h"
#include <dlfcn.h>

#ifndef UNPACK_H
   #include "hitunpack.h"
#endif

#include "../unpack/unpack.h"

Z32 *hit_gethits ( N32 type, Z32 *first, N64 offset, Z32 *tablesize )
{

  hit tmphit;
  Z32 i; 
  Z8  filename[256];
  void *p;
  void *(*gh) ();

  sprintf (filename, "libunpack_e.bundle");

  if ((p = dlopen(filename, RTLD_LAZY)) != NULL)
    {
      if ((gh = dlsym(p, "gethits")) != NULL)
	{
	  for ( i = 0; i < INDEX_DEF_FIELDS; i++ )
	    {
	      tmphit.obj[i] = first[i]; 
	    }
	  return (Z32 *)gh ( type, tmphit, offset, tablesize ); 
	}

    }

}

Z32 *hit_lookup ( Z8 *keyword, Z32 *type, Z32 *freq, Z32 *blkcount, N64 *offset )
{
  Z8  filename[256];
  void *p;
  void *(*lu) ();

  sprintf (filename, "libunpack_e.bundle");

  if ((p = dlopen(filename, RTLD_LAZY)) != NULL)
    {
	  if ((lu = dlsym(p, "lookup")) != NULL)
	    {
	      return (Z32 *)lu ( keyword, type, freq, blkcount, offset ); 
	    }
    }
}
