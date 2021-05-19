#include "parserobject.h"


Parser *Parser__init__(Lexer *lexer){
    Parser *self = (Parser *) calloc(1, sizeof(Parser));
    self->lexer = lexer;
    self->queue = NULL;
    self->nqueue = 0;
    self->operators = NULL;
    self->nops = 0;
    self->nnodes = 0;
    self->nodes = NULL;
    self->ast = NULL;
    self->current_token = NULL;
    self->previous_token = NULL;

    /* METHODS */
    self->parse_elements = &Parser_parse_elements;
    self->parse_operators = &Parser_parse_operators;
    self->parse = &Parser_parse;
    self->pop_operator = &Parser_pop_operator;
    self->discard_lparen = &Parser_discard_lparen;
    self->__del__ = &Parser__del__;

    return self;
}

void Parser__del__(Parser *self){

    int i;

    for (i=0;i<self->nops; i++){
        self->operators[i]->__del__(self->operators[i]);
    }

    for (i=0; i<self->nqueue; i++){
        self->queue[i]->__del__(self->queue[i]);
    }

    free(self->operators);
    free(self->queue);

}

void Parser_eat(Parser *self){
    self->previous_token = self->current_token;
    self->current_token = self->lexer->get_next_token(self->lexer);
}

void Parser_parse(Parser *self){

    Token *last_operator=NULL;

    do{
        Parser_eat(self);

        switch(self->current_token->type){

            case TOKEN_ELEMENT:
                self->parse_elements(self);
                break;
            case TOKEN_EOF:
                break;
            case TOKEN_DIV:

            case TOKEN_ADD:

	    case TOKEN_SUB: 

            case TOKEN_POW:

            case TOKEN_MUL:
                if (self->nops > 0)
                {
                    last_operator = self->operators[self->nops-1];
                }else{
                    last_operator = self->current_token;
                }
                if (last_operator != NULL)
                {
                    while((self->nops > 0)
                          &((last_operator->precedence > self->current_token->precedence)
                           |((last_operator->precedence == self->current_token->precedence) & (self->current_token->associative == 'L')))
                          & (last_operator->type != TOKEN_LPAREN))
                    {
                        self->pop_operator(self);
                    }
                    self->parse_operators(self);
                }
                break;
            case TOKEN_LPAREN:
                self->parse_operators(self);
                break;

            case TOKEN_RPAREN:
                while ((self->operators[self->nops-1]->type != TOKEN_LPAREN) & (self->nops>0))
                {

                    self->pop_operator(self);

                }
                if(self->operators[self->nops-1]->type == TOKEN_LPAREN){
			self->discard_lparen(self);
                }
                break;
        }
    }while (self->current_token->type != TOKEN_EOF);

    while (self->nops > 0){
        self->pop_operator(self);
    }
}

void Parser_pop_operator(Parser *self){
        self->nqueue += 1;
        self->queue = (Token **) realloc(self->queue, self->nqueue * sizeof(Token *));
        self->queue[self->nqueue-1] = self->operators[self->nops-1];
        self->nops -= 1;
        self->operators = (Token **) realloc(self->operators, self->nops * sizeof(Token *));
}

void Parser_parse_operators(Parser *self){
        self->nops += 1;
        self->operators = (Token **) realloc(self->operators, self->nops * sizeof(Token *));
        self->operators[self->nops-1] = self->current_token;
}

void Parser_parse_elements(Parser *self){
    self->nqueue += 1;
    self->queue = (Token **) realloc(self->queue, self->nqueue * sizeof(Token *));
    self->queue[self->nqueue-1] = self->current_token;
}

void Parser_discard_lparen(Parser *self){

    self->operators[self->nops-1]->__del__(self->operators[self->nops-1]);
    self->nops -= 1;
    self->operators = (Token **) realloc(self->operators, self->nops * sizeof(Token *));
    self->current_token->__del__(self->current_token);
}

/* This implementation does not implement composite functions,functions with variable number of arguments, and unary operators.


while there are tokens to be read:
    read a token.
    if the token is a number, then:
        push it to the output queue.
    else if the token is a function then:
        push it onto the operator stack
    else if the token is an operator then:
        while ((there is an operator at the top of the operator stack)
              and ((the operator at the top of the operator stack has greater precedence)
                  or (the operator at the top of the operator stack has equal precedence and the token is left associative))
              and (the operator at the top of the operator stack is not a left parenthesis)):
            pop operators from the operator stack onto the output queue.
        push it onto the operator stack.
    else if the token is a left parenthesis (i.e. "("), then:
        push it onto the operator stack.
    else if the token is a right parenthesis (i.e. ")"), then:
        while the operator at the top of the operator stack is not a left parenthesis:
            pop the operator from the operator stack onto the output queue.
        #If the stack runs out without finding a left parenthesis, then there are mismatched parentheses.
        if there is a left parenthesis at the top of the operator stack, then:
            pop the operator from the operator stack and discard it
        if there is a function token at the top of the operator stack, then:
            pop the function from the operator stack onto the output queue.
#After while loop, if operator stack not null, pop everything to output queue
if there are no more tokens to read then:
    while there are still operator tokens on the stack:
        If the operator token on the top of the stack is a parenthesis, then there are mismatched parentheses.
        pop the operator from the operator stack onto the output queue.
exit.*/
