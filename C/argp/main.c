#include <stdio.h>
#include <stdlib.h>
#include <argz.h>
#include <argp.h>
#include <error.h>

#define PROGNAME "progname"
#define PROGVERSION "1.0"

const char *argp_program_bug_address = "<bug-gnu-utils@gnu.org>";
const char *argp_program_version = 
"progname 1.0\n"
"\n"
"Copyright (c) 20XX J. Doe.\n"
"MIT License.\n"
"\n"
"Written by J. Doe.\n";

/* Program documentation. */
static char doc[] = "test - a program with options and arguments using argp.\v"
"It can be parsed by help2man for generating a man page.";

/* A description of the arguments we accept. */
static char args_doc[] = "ARG1 [ARG2]";

struct arguments
{
    char *argz;
    size_t argz_len;
};

static int parse_opt (int key, char *arg, struct argp_state *state)
{
    struct arguments *a = state->input;
    switch (key)
    {
        case 'd': 
            unsigned int i;
            unsigned int dots = 0;
            if (arg == NULL)
            {
                dots = 1;
            }
            else
            {
                dots = atoi (arg);
            }
            for (i = 0; i < dots; i++){printf (".");}
            printf("\n");
            break;
        case 'p':
            parse_opt('d', "3", state);
            break;
            break;
        case ARGP_KEY_ARG:
            argz_add (&a->argz, &a->argz_len, arg);
            break;
        case ARGP_KEY_INIT:
            a->argz = 0;
            a->argz_len = 0;
            break;
        case ARGP_KEY_END:
             {
                 size_t count = argz_count (a->argz, a->argz_len);
                 if (count > 2)
                     argp_failure (state, 1, 0, "too many arguments");
                 else if (count < 1)
                     argp_failure (state, 1, 0, "too few arguments");
             }
             break;
    }
    return 0;
}
struct argp_option options[] =
{
    { "dot"   , 'd', "NUM", OPTION_ARG_OPTIONAL, "Show a dot on the screen"},
    { 0       , 'p', "NUM", OPTION_ALIAS       , "Show a dot on the screen"},
    { 0 }
};

struct argp argp = { options, parse_opt, args_doc, doc };

int main (int argc, char **argv)
{
    struct arguments arguments;
    error_t err;
    err = argp_parse (&argp, argc, argv, 0, 0, &arguments);

    if(err == 0)
    {
        const char *prev = NULL;
        char *word;
        while ((word = argz_next (arguments.argz, arguments.argz_len, prev)))
        {
            printf (" %s", word);
            prev = word;
        }
        printf ("\n");
        free (arguments.argz);
        return EXIT_SUCCESS;
    }
    else
    {
        return EXIT_FAILURE;
    }
}
