#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <stdio.h>
#include "lexerobject.h"

/**
 * @brief Lexer constructor
 * @param contents Content to tokenize
 */
Lexer *Lexer__init__(char *contents)
{
    Lexer *self = (Lexer *)calloc(1, sizeof(Lexer));
    self->contents = contents;
    self->i = 0;
    self->c = contents[self->i];

    self->advance = &Lexer_advance;
    self->__del__ = &Lexer__del__;
    self->get_next_token = &Lexer_get_next_token;
    self->skip_whitespace = &Lexer_skip_whitespace;
    self->collect_id = &Lexer_collect_id;
    self->get_current_char_as_string = &Lexer_get_current_char_as_string;

    return self;
}
/**
 * @brief Lexer destructor
 * @param self Pointer to a Lexer
 */
void Lexer__del__(Lexer *self){
    free(self);
}

/**
 * @brief Advance method
 * @details Go the next character
 * @param self Pointer to a Lexer
 */
void Lexer_advance(Lexer *self)
{
    if (self->c != '\0' && self->i < strlen(self->contents))
    {
        self->i += 1;
        self->c = self->contents[self->i];
    }
}

/**
 * @brief Skip whitespace method
 * @detail Skip whitespaces
 * @param self Pointer to a lexer
 */
void Lexer_skip_whitespace(Lexer *self)
{
    while (self->c == ' ' || self->c == SPACECHAR)
    {
        self->advance(self);
    }
}


Token *Lexer_get_next_token(Lexer *lexer)
{
    Token *token;
    short int flag = 1;
    if(lexer->c != '\0' && lexer->i < strlen(lexer->contents))
    {
        lexer->skip_whitespace(lexer);
        if (isalnum(lexer->c))
        {
            token = lexer->collect_id(lexer);
            flag = 0;
        }
        if (flag){
            switch (lexer->c)
            {
                case '(': token = Token__init__(TOKEN_LPAREN, Lexer_get_current_char_as_string(lexer));
                          lexer->advance(lexer);
                          break;
                case ')': token = Token__init__(TOKEN_RPAREN, Lexer_get_current_char_as_string(lexer));
                          lexer->advance(lexer);
                          break;
                case '{': token = Token__init__(TOKEN_LPAREN, Lexer_get_current_char_as_string(lexer));
                          lexer->advance(lexer);
                          break;
                case '}': token = Token__init__(TOKEN_RPAREN, Lexer_get_current_char_as_string(lexer));
                          lexer->advance(lexer);
                          break;
                case '+': token = Token__init__(TOKEN_ADD, Lexer_get_current_char_as_string(lexer));
                          lexer->advance(lexer);
                          break;
                case '/': token = Token__init__(TOKEN_DIV, Lexer_get_current_char_as_string(lexer));
                          lexer->advance(lexer);
                          break;
                case '-': token = Token__init__(TOKEN_ADD, Lexer_get_current_char_as_string(lexer));
                          lexer->advance(lexer);
                          break;
                case '*': token = Token__init__(TOKEN_MUL, Lexer_get_current_char_as_string(lexer));
                          lexer->advance(lexer);
                          break;
                default:
                    token = Token__init__(TOKEN_EOF, "\0");
            }
        }
    }else{
        token = Token__init__(TOKEN_EOF, "\0");
    }
    
    return token;
}



Token *Lexer_collect_id(Lexer *self)
{
    char* value = calloc(1, sizeof(char));
    value[0] = '\0';

    while (isalnum(self->c))
    {
        char* s = self->get_current_char_as_string(self);
        value = realloc(value, (strlen(value) + strlen(s) + 1) * sizeof(char));
        strcat(value, s);
        free(s);

        self->advance(self);
    }

    return Token__init__(TOKEN_ELEMENT, value);
}



char *Lexer_get_current_char_as_string(Lexer *self)
{
    char *str = (char *)calloc(2, sizeof(char));
    str[0] = self->c;
    str[1] = '\0';

    return str;
}
