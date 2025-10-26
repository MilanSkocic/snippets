#ifndef CMAIN_H
#define CMAIN_H

/* SIMPLE DERIVED TYPE*/
/* C structure mirroring the derived type in Fortran */
struct fobj_simple_capi{
    int n;
    float array[3];
    char name[33];
};

extern struct fobj_simple_capi obj_simple_capi;



/* COMPLEX DERIVED TYPE*/
/* Methods defined in Fortran for C interoparibility */
extern void * objcmpl_capi_init(int n, float value);
extern void objcmpl_capi_del(void *o);
extern void objcmpl_capi_print(void *o);
extern char* objcmpl_capi_getname(void *o);

/* Let's write a C struct that encapsulate the Fortran derived type void* and its methods defined above*/
/* It will look like we are using the Fortran derived directly */
/* We can use the same names as the ones defined in Fortran */
struct objcmpl{
    void * fobj;
    void (*print)(struct objcmpl *);
};

struct objcmpl * objcmpl_init(int, float);
void objcmpl_print(struct objcmpl *);
void objcmpl_del(struct objcmpl *);

void objcmpl_print(struct objcmpl *self){
    objcmpl_capi_print(self->fobj);
}

void objcmpl_del(struct objcmpl *self){
    objcmpl_capi_del(self->fobj);
    free(self);
}

struct objcmpl * objcmpl_init(int n, float value){
    struct objcmpl *self = (struct objcmpl *)malloc(sizeof(struct objcmpl *));
    self->fobj = objcmpl_capi_init(n, value);
    self->print = &objcmpl_print;
    return self;
}

#endif
