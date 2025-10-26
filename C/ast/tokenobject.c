#include<stdlib.h>
#include<stdio.h>
#include<string.h>
#include"tokenobject.h"

/* static char ELEMENTS[5] = {'R', 'C', 'L', 'Q', 'W'}; */


/**
 * @brief Token constructor
 * @param type Type of token
 * @param value Value of token
 */
Token *Token__init__(int type, char *value)
{

    Token *self = (Token *)calloc(1, sizeof(Token));
    self->type = type;
    self->value = value;
    self->print = &Token_print;
    self->__del__ = &Token__del__;

    switch (self->type){
        case TOKEN_ELEMENT:
            self->precedence = 1;
            self->associative = 'L';
	    break;
        case TOKEN_SUB:
            self->precedence = 2;
            self->associative = 'L';
        case TOKEN_ADD:
            self->precedence = 2;
            self->associative = 'L';
            break;
        case TOKEN_DIV:
            self->precedence = 3;
            self->associative = 'L';
        case TOKEN_MUL:
            self->precedence = 3;
            self->associative = 'L';
            break;
        case TOKEN_POW:
            self->precedence = 4;
            self->associative = 'R';
            break;
        default:
            self->precedence = 0;
            self->associative = 'L';
    }
    return self;

}

/**
 * @brief Token destructor
 */
void Token__del__(Token *self){
    free(self->value);
    free(self);

}

void Token_print(Token *self){
    printf("Token: value, type = %s - %d\n", self->value, self->type);
}
