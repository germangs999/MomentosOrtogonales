/* 
 * File:   binomials.c
 * Author: Alfonso Estudillo Romero <alfonsoer at gmail.com>
 *
 * Created on December 4, 2014, 3:27 AM
 * 
 * Description: Functions that compute binomial coefficients
 */

#include <stdio.h>
#include <stdlib.h>
#include <memory.h>

/**
 * This function computes the Binomial Coefficients up to N order
 * @param N The order of the filter
 * @return A Binomial filter
 */
double *ComputeBinomialCoef(int N) {
    double Coef;
    int C;
    int L;
    L = N;

    if (N < 0){
        N = 0;
    }
    
    double *Bin;
    int i;
    if ((Bin = (double *) malloc(sizeof ( double) * (N + 1))) == NULL) {
        printf("Cannot allocate Binomial vector memory\n");
        return NULL;
    }
    memset(Bin, 0.0, sizeof ( double) * (N + 1));

    //Inicializamos el vector con el filtro básico [1 1]
    Bin[0] = 1;
    if (N < 1) {
        return Bin;
    }
    
    Bin[1] = 1;
    if (N < 2) {
        return Bin;
    }
    
    Bin[N] = 1;
    Bin[1] = N;
    if (N < 3) {
        return Bin;
    }
    
    Bin[N - 1] = N;
    if (N < 4) {
        return Bin;
    }

    Coef = N;
    for (C = 2; C < (N / 2) + 1; C++) {
        Coef = (Coef * (N - C + 1)) / C;
        Bin[C] = Coef;
        if (C != N - C)
            Bin[N - C] = Coef;
    }

    return Bin;
}

