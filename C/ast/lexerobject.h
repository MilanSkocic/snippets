#ifndef LEXEROBJECT_H
#define LEXEROBJECT_H

#include"tokenobject.h"

/**
 * @brief Lexer
 * @detail Lexer for tokenizing the content.
 */
typedef struct lexer_struct 
{
    char c; /**< Character */
    size_t i; /**< Character index */
    char *contents; /**< Content to tokenize */
    
    void (*__del__)(struct lexer_struct *self);
    void (*advance)(struct lexer_struct *self);
    struct token_struct *(*get_next_token)(struct lexer_struct *self);
    void (*skip_whitespace)(struct lexer_struct *self);
    struct token_struct *(*collect_id)(struct lexer_struct *self);
    struct token_struct *(*collect_string)(struct lexer_struct *self);
    char *(*get_current_char_as_string)(struct lexer_struct *self);
}Lexer;


/* METHODS */
Lexer *Lexer__init__(char *contents);
void Lexer__del__(Lexer *self);
void Lexer_advance(Lexer *self);
void Lexer_skip_whitespace(Lexer *self);
Token *Lexer_get_next_token(Lexer *self);
Token *Lexer_collect_string(Lexer *self);
Token *Lexer_collect_id(Lexer *self);
Token *Lexer_advance_with_token(Lexer *self, Token *token);
char *Lexer_get_current_char_as_string(Lexer *self);


#endif
