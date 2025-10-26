#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <complex.h>
#include "parserobject.h"
#include "visitorobject.h"
#include "version.h"


int main(int argc, char **argv){

    int i, verbose;

    printf("VERSION = %d\n", progcmake_VERSION_MAJOR);

    char *input = "Wdox";

    printf("Input=%s\n", input);
    
    Lexer *lexer = Lexer__init__(input);
    
    verbose = 1;
    Parser *parser = Parser__init__(lexer, verbose);
    AstNode *ast = parser->parse(parser);
    
    AstVisitor *visitor = AstVisitor__init__();
    
    char *infix ;
    infix = visitor->get_infix(visitor, ast);
    printf("Result=%s\n", infix);
    
    visitor->init_parameters(visitor, ast);
    visitor->rename_parameters(visitor);
    printf("visitor->n = %d\n", visitor->n);
    visitor->p[0] = 30.0;
    visitor->p[1] = 1.0;
    visitor->p[2] = 0.5;
    for(i=0; i<visitor->n; i++){
        printf("%s=%.6f\n", visitor->pnames[i], visitor->p[i]);
    }
    
    double w = 1.0;
    double complex result;
    for(i=0; i<1; i++){
        result = visitor->eval(visitor, ast, NULL, &w);
        printf("Final %.6f %.6f\n", creal(result), cimag(result));
    }


    lexer->__del__(lexer); /* delete lexer */
    parser->__del__(parser); /* delete queue and operators */
    ast->__del__(ast); /* delete all nodes and tokens */
    visitor->__del__(visitor); /* delete visitor */

    return 0;
}
