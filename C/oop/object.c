/**
 * @file object.c
 */

#include "object.h"

/* Fortran routines */
/**
 * @brief C wrapper for Fortran fib
 * @details Fortran code
 * @param x Pointer to the array
 * @param n Pointer to the array size.
 */
extern void fibf90_(double *x, size_t *n);


/* Fortran routines */
/**
 * @brief C wrapper for Fortran dscal 
 * @details Fortran code
 * @param x Pointer to the array
 * @param a Pointer to the scalar
 * @param n Pointer to the array size.
 */
extern void dscal_(size_t *n, double *da, double *dx, int *incx);

/**
 * @brief Object in C
 * @details Structure containing attributes and methods.
 */
struct object_t{
    size_t n; /**< Size */
    double *data; /**< Data container */

    void (*init)(Object *, size_t); /**< Init */
    void (*destroy)(Object *); /**< Destroy */
    void (*print)(Object *); /**< Display */
};

/**
 * @brief Initialization
 * @details Initialize the Object
 * @param self Pointer to Object
 * @param n Size of the container
 */
void Object_init(Object *self, size_t n){
    self->n = n;
    self->data = (double *)calloc(self->n, sizeof(double));
}

/**
 * @brief Destruction 
 * @details Destroy the Object
 * @param self Pointer to Object
 */
void Object_destroy(Object *self){
    free(self->data);
    free(self);
}

/**
 * @brief Display 
 * @details Display the data in Object
 * @param self Pointer to Object
 */
void Object_print(Object *self){

    size_t i;
    for(i=0; i<self->n; i++){
        printf("data[%ld]=%f\n", i, self->data[i]);
    }
}


/**
 * @brief Create and allocate Object 
 * @details Creation of the Object
 * @param n Size of the container
 */
Object *Object_create(size_t n){
    Object *self;
    self = (Object *)calloc(1, sizeof(Object));
    self->init = &Object_init;
    self->destroy = &Object_destroy;
    self->print = &Object_print;

    self->init(self, n);
    return self;
}


int main(int argc, char **argv){


    double a = 2.0;
    int incx = 1;

    Object *obj = Object_create(100);
    obj->print(obj);

    fibf90_(obj->data, &(obj->n));
    obj->print(obj);
    dscal_(&(obj->n), &a, obj->data, &incx);
    obj->print(obj);
    obj->destroy(obj);

    return EXIT_SUCCESS;
}