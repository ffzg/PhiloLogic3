/*
 *  scale:  translate (using various techniques) from an input
 *  buffer at one resolution to an output buffer at a different
 *  resolution.
 */

/* Prototypes for scale.c */

void 
scale2bw (unsigned char *ibm, unsigned char *obm, long unsigned int *w, long unsigned int *l);
void
scale2jbig(unsigned char *ibm, unsigned char *obm, long unsigned int *w, long unsigned int *l);
void 
scale3bw (unsigned char *ibm, unsigned char *obm, long unsigned int *w, long unsigned int *l);
void
scale4bw (unsigned char *ibm, unsigned char *obm, long unsigned int *w, long unsigned int *l);
void 
scale3gs (unsigned char *ibm, unsigned char *obm, long unsigned int *w, long unsigned int *l);
void
scale4gs (unsigned char *ibm, unsigned char *obm, long unsigned int *w, long unsigned int *l);
void 
scale5gs (unsigned char *ibm, unsigned char *obm, long unsigned int *w, long unsigned int *l);
