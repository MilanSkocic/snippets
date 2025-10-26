#include <ncurses.h>

int main(){
    
    int xmax, ymax;

    initscr();
    noecho();
    curs_set(0);

    getmaxyx(stdscr, ymax, xmax);
    
    WINDOW *win = newwin(ymax/2, xmax/2, ymax/4, xmax/4);
    box(win, 0,0);
    
    mvwprintw(win, 0, 2, "File");
    mvwprintw(win, 0, 7, "File");

    wgetch(win);
    endwin();

    return 0;

}
