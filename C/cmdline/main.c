#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct option{
    char name[33];
    char letter;
    int args;
    char help[65];
};

struct option options[]={{"--version", 'v', 0, "Display version."}};

int print_args(int argc, char **argv){
    size_t i;
    for(i=0;i<argc;i++){
        printf("arg %ld = %s\n", i, argv[i]);
    }
    return 0;
}

int parse_opt(struct option options[], int argc, char **argv){

    size_t i;
    for(i=0;i<1;i++){
        printf("%s %c\n", options[i].name, options[i].letter);
    }
    return 0;
}




int main(int argc, char **argv){
    
    print_args(argc, argv);
    parse_opt(options, argc, argv);
    return EXIT_SUCCESS;
}
