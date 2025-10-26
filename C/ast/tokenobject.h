#ifndef TOKENOBJECT_H
#define TOKENOBJECT_H

#include"eis.h"

#define SPACECHAR 10

/**
 * @brief Token types
 */
enum token_types {
    TOKEN_ELEMENT,
    TOKEN_LPAREN,
    TOKEN_RPAREN,
    TOKEN_ADD,
    TOKEN_DIV,
    TOKEN_POW,
    TOKEN_MUL,
    TOKEN_SUB,
    TOKEN_EOF};

/**
 * @brief Token structure
 * @detail Tokens found in contents.
 */
typedef struct token_struct{

    enum token_types type; /**< Token type */
    char *value; /**< Token value */
    int precedence; /**< Priority */
    char associative;
    void (*print)(struct token_struct *self); /* print in verbose = 1 */
    void (*__del__)(struct token_struct *self); /**< Destructore*/
}Token;


/* METHODS */
Token *Token__init__(int type, char *value);
void Token__del__(Token *self);
void Token_print(Token *self);

#endif
