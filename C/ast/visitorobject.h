#ifndef VISITOROBJECT_H
#define VISITOROBJECT_H

#include"tokenobject.h"
#include"astobject.h"

typedef struct ast_visitor_struct{
    
    char *value;
    double *p;
    char **pnames;
    int n;
    int k;
    char *(*get_infix)(struct ast_visitor_struct *self, AstNode *node);
    void (*init_parameters)(struct ast_visitor_struct *self, AstNode *node);
    void(*rename_parameters)(struct ast_visitor_struct *self);
    double complex (*eval)(struct ast_visitor_struct *self, AstNode *node, double *p, double *w);
    void (*__del__)(struct ast_visitor_struct *self);


}AstVisitor;

/* METHODS */
AstVisitor *AstVisitor__init__(void);
char *AstVisitor_get_infix(AstVisitor *self, AstNode *node);
void AstVisitor_init_parameters(AstVisitor *self, AstNode *node);
void AstVisitor_rename_parameters(AstVisitor *self);
double complex AstVisitor_eval(AstVisitor *self, AstNode *node, double *p, double *w);
void AstVisitor__del__(AstVisitor *self);

#endif
