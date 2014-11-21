// $Id: mkhuff.c,v 2.10 2004/05/28 19:22:02 o Exp $
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

/* mkhuff.c
 *
 *  Makes a huffman code for the weights on standard input.
 *  Each line should have a string of non-blanks, the "tag",
 *  and an integer weight.  Input should be sorted in decreasing order
 *  by weight.  There must be at least two lines of input.
 */

struct huffnode {
    struct huffnode *left;
    struct huffnode *right;
    struct huffnode *next;
    struct huffnode *prev;
    char *tag;
    long int weight;
};

char *strsave(s)	/* save string s somewhere */
char *s;
{
    char *p, *malloc();

    if ((p = malloc(strlen(s)+1)) != NULL) strcpy(p, s);
    return(p);
}

struct huffnode *make_new_node()
{
    struct huffnode *new;
    new = (struct huffnode *) malloc(sizeof (struct huffnode));
    if (new == NULL) {
	fprintf(stderr,"fatal: problem allocating new node\n");
	exit(1);
    }
    new->left = NULL;
    new->right = NULL;
    new->next = NULL;
    new->prev = NULL;
    new->tag = NULL;
    new->weight = 0;
    return(new);
}

/* two linked lists are used -- one for the as yet unprocessed leaves
   (lhead and ltail) and one for the internal nodes (head and tail) */

struct huffnode *head,*tail,*lhead,*ltail,*bottom1,*bottom2;

read_keys()
{
    char tagbuf[1000];
    long int w;

    struct huffnode *current;
    lhead = make_new_node();
    ltail = make_new_node();
    current = lhead;

    while (scanf("%[^ ] %ld\n", tagbuf, &w) == 2) {
	/* printf("read %s %d\n",tagbuf,w); */
	current->next = make_new_node();
	if (current->next == NULL) {
	    fprintf(stderr,"fatal: problem allocating new node\n");
	    exit(1);
	}
	(current->next)->prev = current;
	current = current->next;
	current->tag = strsave(tagbuf);
	if (current->tag == NULL) {
	    fprintf(stderr,"fatal: problem storing tag\n");
	    exit(1);
	}
	current->weight = w;
    }

    current->next = ltail;
    ltail->prev = current;
    
    /* now initialize the internal node linked list */
    head = make_new_node();
    tail = make_new_node();
    head->next = tail;
    tail->prev = head;
}

print_weights_in_queue(title,start)
char *title;
struct huffnode *start;
{
    struct huffnode *current;
    printf("%s: ",title);
    for (current=start; current->next != NULL; current=current->next)
	printf("%ld ",current->weight);
    printf("\n");
}

int find_smallest_nodes()
{
    /* find the next two smallest nodes -- at the same time, figure out
       if there are two nodes left */
    if ((ltail->prev)->prev != NULL) {
	/* there is at least one unprocessed leaf left */
	if ((ltail->prev)->weight <= (tail->prev)->weight) {
	    bottom1 = ltail->prev;
	    if (((bottom1->prev)->prev != NULL) &&
		((bottom1->prev)->weight <= (tail->prev)->weight))
		/* there is another unprocessed leaf left, and it's small */
		    bottom2 = bottom1->prev;
	    else
		/* either there is only one unprocessed leaf or the next
		   smallest unprocessed leaf is too large */
		bottom2 = tail->prev;
	} else {
	    bottom1 = tail->prev;
	    if (((bottom1->prev)->prev == NULL) ||
	        ((ltail->prev)->weight <= (bottom1->prev)->weight))
		bottom2 = ltail->prev;
	    else bottom2 = bottom1->prev;
	}
    } else {
	/* no unprocessed leaves -- choose the two smallest internal nodes */
	bottom1 = tail->prev;
	if ((bottom1->prev)->prev == NULL)
	    /* we're done -- there is only one internal node left */
	    return(0);
	else bottom2 = bottom1->prev;
    }
    return(1);
}

make_code()
{
    struct huffnode *newnode;

    /* we can start by assuming the last two leaves are the smallest nodes */
    bottom1 = ltail->prev;
    bottom2 = bottom1->prev;
    do {
	/* printf("combining %d %d\n",bottom1->weight,bottom2->weight); */
	/* make a new node */
	newnode = make_new_node();
	newnode->right = bottom1;
	newnode->left = bottom2;
	newnode->weight = bottom1->weight + bottom2->weight;
	/* take these nodes out of line */
	(bottom1->prev)->next = bottom1->next;
	(bottom1->next)->prev = bottom1->prev;
	(bottom2->prev)->next = bottom2->next;
	(bottom2->next)->prev = bottom2->prev;
	/* insert the new node at the head of the list of internal nodes */
	newnode->prev = head;
	newnode->next = head->next;
	head->next = newnode;
	(newnode->next)->prev = newnode;
	/* print_weights_in_queue("leaves",lhead->next); */
	/* print_weights_in_queue("internal nodes",head->next); */
    } while (find_smallest_nodes());
}

char code[1000];

walk_tree(node,depth)
struct huffnode *node;
int depth;
{
    if (node->right == NULL) {	/* this is a leaf -- print */
	code[depth] = '\0';
	printf("%s %s %ld\n",node->tag,code,node->weight);
	return;
    }
    code[depth] = '0';
    walk_tree(node->right,depth+1);
    code[depth] = '1';
    walk_tree(node->left,depth+1);
}

print_code()
{
    walk_tree(head->next,0);
}

main()
{
    read_keys();
    /* print_weights_in_queue("leaves",lhead->next); */
    make_code();
    print_code();
    exit (0);
}


