/** 
 * @file src1.c
 * 
 * Butler-Volmer equation.
 *
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
 * along with this program.  If not, see <https://www.gnu.org/licenses/>. 
 *
 * Author: Milan Skocic <milan.skocic@gmail.com>
 */


#include "electrox.h"

/**
 * @brief Compute Butler Volmer equation
 * @details details
 * @param OCV Open Circuit Potential in Volts
 * @param U Potential to compute in Volts
 * @param j0 Exchange current density in A.cm-2
 * @param jdla Anodic diffusion limiting current density in A.cm-2
 * @param jdlc Cathodic diffusion limiting current density in A.cm-2
 * @param aa Anodic transfer coefficient
 * @param ac Cathodic transfer coefficient
 * @param za Anodic number of exchanged electrons
 * @param zc Cathodic number of exchanged electrons
 * @param S Area in cm2
 * @param T Temperature in °C
 * @return I Current in A.
 */
double bv(double OCV, double U, double j0, double jdla, double jdlc,
          double aa, double ac, double za, double zc,
          double S, double T){

          double kTe;
          double num;
          double denom;
          double I;

    kTe = kB * (T+T_K) / qe;
    num = j0 * (exp(aa*za*(U-OCV)/kTe) -  exp(-ac*zc*(U-OCV)/kTe));
    denom = 1 + j0/jdla*exp(aa*za*(U-OCV)/kTe) + j0/jdlc*exp(-ac*zc*(U-OCV)/kTe);
    
    I = S*num/denom;
    
    return I;

}

/**
 * @example example1.c
 */


