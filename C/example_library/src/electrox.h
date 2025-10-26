/** 
 * @file electrox.h
 *
 * Header of the library libelectox.
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
 * Author: Milan Skocic <milan.skocic@gmail.com>
 */

#ifndef ELECTROX_H
#define ELECTROX_H

#include<stdlib.h>
#include<stdio.h>
#include<math.h>
/** @brief 0.0°C in Kelvin */
#define T_K (273.15) /**< Conversion offset from degree Celsius to degree Kelvin  */

/** @brief Boltzmann Constant */
#define kB (1.380649e-23) /**< Boltzmann Constant */

/** @brief Elementary charge */
#define qe (1.602176634e-19) /**< Elementary charge */


double get_kTe(double temperature);

double bv(double OCV, double U, double j0, double jdla, double jdlc,
          double aa, double ac, double za, double zc,
          double S, double T);

double roundn(double x, int n);


#endif
