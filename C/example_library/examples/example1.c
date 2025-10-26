/** 
 * @file example1.c
 *
 * Examples.
 * Copyright (C) 2020-2021  Milan Skocic.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>. */

#include "electrox.h"

void run_bv(){


    double OCV=0.0;
    double U=0.0;
    double j0=1e-6;
    double jdla=1e6;
    double jdlc=1e6;
    double aa=0.5;
    double ac=0.5;
    double za=1;
    double zc=1;
    double S=1.0;
    double T=25.0;

    double computed;
    double expected;

    computed = bv(OCV, U, j0, jdla, jdlc, aa, ac, za, zc, S, T);

}




int main (int argc, char **argv)
{

    run_bv();

}

