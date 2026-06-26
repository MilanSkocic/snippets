#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <error.h>

struct option_t {
    char *l; // long option
    char *s; // short option
    char *help;
};

static struct option_t loptions[]={
    {"--version", "-v", "Display version and exit."},
    {"--usage",   "-u", "Display usage and exit."},
    {"--help",    "-h", "Display help and exit."},
    {NULL,        NULL, NULL}
};

static char *long2short(char *option, struct option_t *options){
    int i=0;
    
    // Check option structure. If incorrect return NULL.
    if(option==NULL){return NULL;}
    if(strlen(option)<3){return NULL;}
    if(!((option[0]=='-') && (option[1]=='-'))){return NULL;}

    while(options[i].l!=NULL){
        if(strcmp(option, options[i].l)==0){return options[i].s;}
        else{i++;}
    }
    return NULL;
}

void print_options(struct option_t *options){
    int i=0;
    while(options[i].l!=NULL){
        printf("    %-2s, %-15s    %-72s\n", options[i].s, options[i].l, options[i].help);
        i++;
    }
}

int main(int argc, char **argv){
    
    int i;
    char *s;

    for(i=1;i<argc;i++){
        s = long2short(argv[i], loptions);
        if(s!=NULL){argv[i]=s;}
    }
    
    print_options(loptions);
    

    return EXIT_SUCCESS;
}
