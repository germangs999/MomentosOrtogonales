/* 
 * File:   statistics.c
 * Author: Alfonso Estudillo Romero <alfonsoer at gmail.com>
 *
 * Created on April 9, 2015, 12:47 PM
 * 
 * Description: 
 * Cálculo de estadísticas
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <memory.h>
#include "imagetypes.h"
#include "statistics.h"

double getMean(image_double_t A){
    double mean;
    int i;
    mean = 0.0;
    for(i=0; i<A.H0*A.W0; i++){
        mean = A.data[i] + mean;
    }
    mean = (double)mean / (double)(A.H0*A.W0);
    return mean;
}

