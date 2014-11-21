/*
 * writepng.c -  handles writing of PNG files. 
 *
 * Contains: 
 *   WritePNG(fp, pic, w, h, rmap, gmap, bmap, numcols, colorstyle)
 *
 */

/*
  Cornell Research Foundation, Inc., the copyright holder in this software
  hereby dedicates this software and all rights therein to the public and
  places it in the public domain to be fully used without accounting or
  recourse.  This dedication is made AS IS without any warranties of any sort
  and is effective 2001-07-01.
  
  Author:  
     Richard Marisa, 
     Cornell Information Technologies
     rjm2@cornell.edu

  This file is a drop-in replacement (except for then name of the file and 
  subroutine) for xvgifwr.c in tif2gif, thereby creating tif2png.
  WritePNG depends on libpng and libz.  See
      http://www.libpng.org/pub/png/libpng.html
*/


#include <stdio.h>
#include "png.h"

typedef unsigned char byte;
int i;

/*************************************************************/
int WritePNG(fp, pic, w, h, rmap, gmap, bmap, numcols, colorstyle, trans)
FILE *fp;
byte *pic;
int   w,h;
byte *rmap, *gmap, *bmap;
int   numcols, colorstyle;
int   trans;
{
  png_structp png_ptr;
  png_infop info_ptr;
  png_colorp palette;

  if (fp == NULL) {
    fclose(fp);
    return;
  }

  png_ptr = png_create_write_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);

  if (png_ptr ==  NULL) {
    fclose(fp);
    return;
  }

  info_ptr = png_create_info_struct(png_ptr);
  if (info_ptr == NULL) {
    fclose(fp);
    png_destroy_write_struct(&png_ptr, (png_infopp)NULL);
    return;
  }

  png_init_io(png_ptr, fp);

  png_set_IHDR(png_ptr, info_ptr, w, h, 8, PNG_COLOR_TYPE_PALETTE, PNG_INTERLACE_NONE, 
               PNG_COMPRESSION_TYPE_BASE, PNG_FILTER_TYPE_BASE);
  png_set_compression_level(png_ptr, 1);

  palette = (png_colorp)png_malloc(png_ptr, 256 * sizeof (png_color));
  for (i=0; i<256; i++) {
    palette[i].red   = rmap[i];
    palette[i].green = gmap[i];
    palette[i].blue  = bmap[i];
  }
  png_set_PLTE(png_ptr, info_ptr, palette, 256);

  png_write_info(png_ptr, info_ptr);

  /* write the image */
  for (i = 0; i<h; i++) {
   png_write_rows(png_ptr, (png_bytepp)&pic, 1);
   pic += w;
  }

  png_write_end(png_ptr, info_ptr);
  png_destroy_write_struct(&png_ptr, (png_infopp)NULL);
  fclose(fp);
  return;
}
