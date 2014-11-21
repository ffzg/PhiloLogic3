// $Id: getresource.c,v 2.10 2004/05/28 19:22:04 o Exp $
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
#include <stdlib.h>
#include <string.h>
#include "getresource.h"

char *getresource(type, name)
     ResourceType type;
     char *name;
{
  char *fname;
  static char *systemdir = NULL;

  if (NULL == systemdir)
    if (NULL == (systemdir=getenv("SYSTEM_DIR"))) systemdir = NULL;

  switch (type) {
  case resourcetype_filename:
    /* note space leak.  Who cares?  This shouldn't get called very */
    /* often... */
    if (NULL==(fname = malloc(strlen(systemdir) + strlen(name) + 1))) {
      fprintf(stderr,"malloc failed in getresource()!!\n");
      exit(1);
    }
    strcpy(fname,systemdir);
    //    fname[strlen(systemdir)] = '\0';
    strcat(fname,name);
    //fname[strlen(systemdir) + strlen(name) + 1] = '\0';
    /* fprintf(stderr,"getresource:fname=\"%s\"\n",fname); */
    return(fname);

  case resourcetype_variable:
    return(getenv(name));
  }
}


