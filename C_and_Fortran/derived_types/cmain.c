#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "cmain.h"


int main(void){
    int i;

    /*SIMPLE FORTRAN DERIVED TYPE*/
    printf("%s\n", obj_simple_capi.name);
    printf("%d\n", obj_simple_capi.n);
    for(i=0;i<3;i++){
        printf("%f\t", obj_simple_capi.array[i]);
    }
    printf("\n");

    struct objcmpl *obj = objcmpl_init(3, 6.0);
    obj->print(obj);
    char *name = objcmpl_capi_getname(obj->fobj);
    printf("%s\n", name);
    objcmpl_del(obj);


    return EXIT_SUCCESS;
}
