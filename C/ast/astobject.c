#include <stdlib.h>
#include <stdio.h>
#include "astobject.h"
#include "visitorobject.h"


AstNode *AstNode__init__(Token *token, AstNode * left, AstNode *right)
{
    AstNode *self = (AstNode *)calloc(1, sizeof(AstNode));

    self->token = token;
    self->left = left;
    self->right = right;
    self->__del__ = &AstNode__del__;
    self->print = &AstNode_print;
    return self;
}

void AstNode__del__(AstNode* self){
    self->token->__del__(self->token);
    if(self->left != NULL){
        self->left->__del__(self->left);
    };
    if(self->right != NULL){
        self->right->__del__(self->right);
    };

    free(self);
}

void AstNode_print(AstNode *self){

    if ((self->left != NULL) & (self->right != NULL)){
    printf("Node: token=%s, left=%s, right=%s\n", self->token->value, 
                                                self->left->token->value, 
                                                self->right->token->value);
    }

    if ((self->left != NULL) & (self->right == NULL)){
        printf("Node: token=%s, left=%s, right=NULL\n", self->token->value, 
                                                self->left->token->value); 
    
    }
    
    if ((self->left == NULL) & (self->right == NULL)){
        printf("Node: token=%s, left=NULL, right=NULL\n", self->token->value); 
    }
}
