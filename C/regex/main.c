#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <regex.h>

int main(void) {
    const char *text = "Alice:25 Bob:30 Charlie:42";

    // Group 1 = name, Group 2 = age
    const char *pattern = "([A-Za-z]+):([0-9]+)";

    regex_t regex;
    regmatch_t matches[3]; // full match + 2 groups

    if (regcomp(&regex, pattern, REG_EXTENDED) != 0) {
        fprintf(stderr, "Failed to compile regex\n");
        return 1;
    }

    const char *cursor = text;

    while (regexec(&regex, cursor, 3, matches, 0) == 0) {
        // Full match
        int full_start = matches[0].rm_so;
        int full_end   = matches[0].rm_eo;

        // Group 1 (name)
        int name_start = matches[1].rm_so;
        int name_len   = matches[1].rm_eo - matches[1].rm_so;

        // Group 2 (age)
        int age_start = matches[2].rm_so;
        int age_len   = matches[2].rm_eo - matches[2].rm_so;

        printf("Match:\n");
        printf("  Name = %.*s\n",
               name_len, cursor + name_start);
        printf("  Age  = %.*s\n",
               age_len, cursor + age_start);

        // Advance past this match
        cursor += full_end;
    }

    regfree(&regex);
    return 0;
}
