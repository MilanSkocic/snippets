#include<stdlib.h>
#include<string.h>
#include<stdio.h>
#include"visitorobject.h"

AstVisitor *AstVisitor__init__(){

    AstVisitor *self = (AstVisitor *)calloc(1, sizeof(AstVisitor));
    self->value = NULL;
    self->p = NULL;
    self->pnames = NULL;
    self->n = 0;
    self->init_parameters = &AstVisitor_init_parameters;
    self->k = 0 ;
    self->rename_parameters = &AstVisitor_rename_parameters;
    self->get_infix = &AstVisitor_get_infix;
    self->eval = &AstVisitor_eval;
    self->__del__ = &AstVisitor__del__;

    return self;

}

void AstVisitor__del__(AstVisitor *self){
    
    int i;
    free(self->value);
    free(self->p);
    for(i=0; i<self->n; i++){
        free(self->pnames[i]);
    }
    free(self->pnames);
    free(self);

}

void AstVisitor_init_parameters(AstVisitor *self, AstNode *node){
    int k, i;
    k = 0;
    i = 0;
    switch(node->token->type){
        case TOKEN_ADD:
        case TOKEN_SUB:
        case TOKEN_MUL:
        case TOKEN_POW:
        case TOKEN_DIV:
            self->init_parameters(self, node->left);
            self->init_parameters(self, node->right);
            break;
        case TOKEN_ELEMENT:  
            switch(node->token->value[0]){ 
                case 'R': 
                case 'L': case 'C':
                    k = 1;
                    break;
                case 'Q':
                    k = 2;
                    break;
                case 'W':
                    switch(node->token->value[1]){
                        case 'd':
                        case 'D':
                        case 'm':
                        case 'M':
                            k = 3;
                            break;
                        default:
                            k = 1;
                            break;
                    }
            }
            self->n += k;
            self->p = (double *)realloc(self->p, self->n * sizeof(double));
            self->pnames = (char **)realloc(self->pnames, self->n * sizeof(char *));
            for(i=k; i>0; i--){
                self->pnames[self->n-i] = calloc(strlen(node->token->value)+1, sizeof(char));
                strcpy(self->pnames[self->n-i], node->token->value);
            }
            break;
        default:
            break;
    }
}

void AstVisitor_rename_parameters(AstVisitor *self){
    
    int i = 0;
    char *name;
    while(i<self->n){
        name = self->pnames[i];
        switch(name[0]){
            case 'R':
            case 'C':
            case 'L':
                i += 1;
               break;
            case 'Q':
               name = self->pnames[i+1];
               name[0] = 'a';
               i += 2;
               break;
            case 'W':
               name = self->pnames[i];
               switch(name[1]){
                   case 'd':
                   case 'D':
                   case 'm':
                   case 'M':
                      name = self->pnames[i+1];
                      name[0] = 'T';
                      name = self->pnames[i+2];
                      name[0] = 'n';
                      i += 3;    
                      break;
                   default:
                     break; 
               }
               break;
            default:
                i += 1;
              break;  
        
        }
            
    }

}

char *AstVisitor_get_infix(AstVisitor *self, AstNode *node){

    char *left;
    char *right;
    char *value = (char *)calloc(1, sizeof(char));
    value[0]  = '\0';
    size_t size;


    switch(node->token->type){
        case TOKEN_ADD:
        case TOKEN_SUB:
        case TOKEN_POW:
        case TOKEN_DIV:
        case TOKEN_MUL:
            left = self->get_infix(self, node->left);
            right = self->get_infix(self, node->right);
            size = strlen(left) + strlen(right) + strlen(node->token->value) + 3;
            value = (char *)realloc(value, size*sizeof(char));
            strcat(value, "(");
            strcat(value, left);
            strcat(value, node->token->value);
            strcat(value, right);
            strcat(value, ")");
            free(left);
            free(right);
            self->value = value;
            break;
        case TOKEN_ELEMENT:
            size = strlen(node->token->value) + 1;
            value = (char *)realloc(value, size*sizeof(char));
            strcpy(value, node->token->value);
            self->value = value;
            break;
        default:
            break;
    }
    return value;
}

double complex AstVisitor_eval(AstVisitor *self, AstNode *node, double *p, double *w){
    
    double complex left, right;
    double complex value;
    
    
    switch(node->token->type){
        case TOKEN_SUB:
        case TOKEN_ADD:
            left = self->eval(self, node->left, p, w);
            right = self->eval(self, node->right, p, w);
            value = left + right;
            break;
        case TOKEN_MUL:
        case TOKEN_POW:
        case TOKEN_DIV:
            left = self->eval(self, node->left, p, w);
            right = self->eval(self, node->right, p, w);
            value = left * right / (left + right);
            break;
        case TOKEN_ELEMENT:
            switch(node->token->value[0]){
                case 'R':
                    value = resistance(self->p+self->k, *w);
                    self->k += 1;
                    break;
                case 'C':
                    value = capacitance(self->p+self->k, *w);
                    self->k += 1;
                    break;
                case 'L':
                    value = inductance(self->p+self->k, *w);
                    self->k += 1;
                case 'Q':
                    value = cpe(self->p+self->k, *w);
                    self->k +=2 ;
                    break;
                case 'W':
                    switch(node->token->value[1]){
                        case 'd':
                        case 'D':
                            value = finite_length_warburg(self->p+self->k, *w);
                            self->k += 3;
                            break;
                        case 'm':
                        case 'M':
                            value = finite_space_warburg(self->p+self->k, *w);
                            self->k += 3;
                            break;
                        default:
                            value = warburg(self->p+self->k, *w);
                            self->k += 1;
                            break;
                    }
                }
                break;
        default:
            value = 0.0;
            break;
        
    }

    return value;
}

