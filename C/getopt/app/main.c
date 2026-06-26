#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <complex.h>
#include <unistd.h>
#include <error.h>
#include "kTe.h"

char *version=
"kTe 1.0.1\n"
"\n"
"Copyright (C) 2026 Milan Skocic\n"
"\n"
"Written by Milan Skocic.\n";

struct array_t{
    double *data;
    size_t n;
	void(*print)(struct array_t);
};

void array_print(struct array_t self){
	int i;
	for(i=0;i<self.n;i++){
		printf("%-+10.2f\n", *(self.data+i));
	}
	
}

void array_table(struct array_t **x, int n, int m){
	int i,j;
	double r;
	for(i=0;i<n;i++){
		for(j=0;j<m;j++){
			r = *(x[j]->data+i);
			printf("%-+10.2f", r);
		}
		printf("\n");
	}
}

static double const e = +1.6021766339999999E-019;
static double const k = +1.3806490000000001E-023;
static const char *separators = " ;:,-!#";

int size(char *s){
    int i = 0;
    char *buf = (char *)malloc(sizeof(char)*strlen(s));
    strncpy(buf,s,strlen(s));
    char *vstr = strtok(buf, separators);
    i=1;
    while(vstr != NULL){
        vstr = strtok(NULL, separators);
        if(vstr != NULL){i++;}
    }
    free(buf);
    return i;

}


void s2d(struct array_t x, char * restrict s){
    
    int i = 0;

    char *buf = (char *)malloc(sizeof(char)*strlen(s));
    strncpy(buf,s,strlen(s));
    char *vstr = strtok(buf, separators);
    *(x.data+i) = atof(vstr);

    i=1;
    while(vstr != NULL){
        vstr = strtok(NULL, separators);
        if(vstr!=NULL){
            *(x.data+i) = atof(vstr);
            i++;
        }
    }
    free(buf);
}


int main(int argc, char** argv){
    size_t i;
    int opt;
    struct array_t T={NULL,0, &array_print};
	struct array_t res={NULL,0, &array_print};
	
	struct array_t **arrays=(struct array_t **)malloc(sizeof(struct array_t *)*2);
	arrays[0] = &T;
	arrays[1] = &res;
    char* args=(char *)malloc(sizeof(char)*128);
    if(args== NULL){
        perror("malloc");
        return EXIT_FAILURE;
    }
    args[0]='\0';

    while ((opt = getopt(argc, argv, ":T:vh")) != -1) {
        switch (opt) {
        case 'T':
            if(strlen(args) > 0){
                strcat(args, " ");
            }
            strcat(args, optarg);
            i++;
            break;
        case 'v':
            printf("%s", version);
            return EXIT_SUCCESS;
            break;
        case ':': 
            printf("option needs a value\n"); 
            break; 
        case '?': 
            printf("unknown option: %c\n", opt);
            break;
        }
    }
    for(; optind < argc; optind++){     
        printf("extra arguments: %s\n", argv[optind]); 
    }
    
    T.n = size(args);
    T.data=(double*)malloc(sizeof(double)*T.n);
    if(T.data == NULL){
        free(args);
        perror("malloc");
        return EXIT_FAILURE;
    }
	res.n = T.n;
	res.data=(double*)malloc(sizeof(double)*T.n);
	if(res.data == NULL){
        free(args);
		free(T.data);
        perror("malloc");
        return EXIT_FAILURE;
    }

    s2d(T, args);

	kTe(T.data, res.data, T.n);
    for(int j=0;j<size(args);j++){
        printf("%-+10.1f    %-+10.2f\n", *(T.data+j), *(res.data+j));
    }
	T.print(T);
	
	array_table(arrays, T.n, 2);
	
    free(T.data);
	free(res.data);
    free(args);
	free(arrays);
    return EXIT_SUCCESS;
}
