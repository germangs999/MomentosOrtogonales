/* 
 * File:   Krawtchouck.c
 * Author: Alfonso Estudillo Romero <alfonsoer at gmail.com>
 *
 * Primer version: 17/05/06.
 * Segunda version: 13/08/2010.
 * Tercer version: November 23, 2014, 3:21 PM
 * 
 * Description: 
 * Calculo de los coeficientes de los filtros de analisis hermite (v2.0)
 */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <memory.h>
#include "binomials.h"
#include "krawtchouk.h"
#include "matrixtypes.h"
#include "imagetypes.h"
#include "matrixoper.h"

/**
 * This function prints the Krawtchouk filters
 * @param Kr
 */
void printKrawtchoukFilter(image_double_t Kr) {
    int i, j;
    if (Kr.data != NULL) {
        for (j = 0; j < Kr.H0; j++) {
            printf("---------");
        }
        printf("\n");
        for (j = 0; j < Kr.H0; j++) {
            for (i = 0; i < Kr.W0; i++) {
                printf(" %f ", Kr.data[j * Kr.W0 + i]);
            }
            printf("\n");
        }
        for (j = 0; j < Kr.H0; j++) {
            printf("---------");
        }
        printf("\n");
    }
}

/**
 * This function computes a set of Krawtchouk filters
 * @param N
 * @param MaxDx
 * @param MaxDy
 * @return 
 */
kr_set_t CreateKrawtchoukSet(int N, int MaxDx, int MaxDy) {
    kr_set_t Set;
    Set.Kr = NULL;
    int Dx, Dy, ID;
    int NFilters = (MaxDx + 1)*(MaxDy + 1);
    int MaxDegree;

    MaxDegree = MaxDx;
    if (MaxDy > MaxDx) {
        MaxDegree = MaxDy;
    }

    if (N < 0 || N < MaxDegree) {
        N = MaxDegree;
    }

    //Set of Filters Allocation
    if ((Set.Kr = (Kr_t *) malloc(sizeof ( Kr_t) * (NFilters))) == NULL) {
        printf("Cannot allocate a Set of Kr Filters (krawtchouk)\n");
        return Set;
    }

    ID = 0;
    Set.NFilters = NFilters;
    for (Dy = 0; Dy <= MaxDy; Dy++) {
        for (Dx = 0; Dx <= MaxDx; Dx++) {
            Set.Kr[ID].N = N;
            Set.Kr[ID].Dx = Dx;
            Set.Kr[ID].Dy = Dy;
            Set.Kr[ID].Filt = Krawtchouk2DFilter(N, Dx, Dy);
            ID++;
        }
    }

    return Set;
}

/**
 * This function computes a normalized 2D Krawtchouk filter
 * @param N The order of the filter. Filter size is N+1
 * @param Dx The degree of the derivative in the X direction
 * @param Dy The degree of the derivative in the Y direction
 * @return Kr The 2D Krawtchouk filter
 */
image_double_t Krawtchouk2DFilter(int N, int Dx, int Dy) {
    image_double_t Kr;
    image_double_t KrX;
    image_double_t KrY;
    image_double_t Norm;

    int h, w;
    Kr.data = NULL;
    if (N < 0 || Dx < 0 || Dx > N || Dy < 0 || Dy > N) {
        return Kr;
    }

    KrX.W0 = N + 1;
    KrX.H0 = 1;
    KrX.data = ComputeKrawtchouk(N, Dx);

    KrY.W0 = 1;
    KrY.H0 = N + 1;
    KrY.data = ComputeKrawtchouk(N, Dy);

    if (KrX.data != NULL && KrY.data != NULL) {

        //Allocate Norm.data memory
        if ((Norm.data = (double *) malloc(sizeof ( double) * (N + 1))) == NULL) {
            printf("Cannot allocate Norm.data matrix memory (krawtchouk)\n");
            return Kr;
        }
        memset(Norm.data, 0.0, sizeof ( double) * (N + 1));
        Norm.W0 = N + 1;
        Norm.H0 = 1;

        if (Dx == 0) {
            for (w = 0; w < KrX.W0; w++) {
                Norm.data[w] = sqrt(KrX.data[w]) / (pow(2, N));
            }
        } else if (Dy == 0) {
            for (w = 0; w < KrY.H0; w++) {
                Norm.data[w] = sqrt(KrY.data[w]) / (pow(2, N)) ;
            }
        } else {
            Norm.data = ComputeKrawtchouk(N, 0);
            for (w = 0; w < Norm.W0; w++) {
                Norm.data[w] = sqrt(Norm.data[w]) / (pow(2, N));
            }
        }

        for (w = 0; w < Norm.W0; w++) {
            KrX.data[w] = KrX.data[w] * Norm.data[Dx];
            KrY.data[w] = KrY.data[w] * Norm.data[Dy];
        }

        Kr = mult_double(KrY, KrX);

        free(KrX.data);
        KrX.data = NULL;

        free(KrY.data);
        KrY.data = NULL;

        free(Norm.data);
        Norm.data = NULL;
    }
    return Kr;
}

/**
 * This function computes a non normalized 1D Krawtchouk filter
 * @param N The order of the filter. Filter size is N+1
 * @param D The maximum degree of the derivative
 * @return Kr The 1D Krawtchouk filter
 */
double *ComputeKrawtchouk(int N, int D) {
    int d;
    double *Kr;
    int i;

    if (N < 0 || D < 0 || D > N) {
        return NULL;
    }

    double *Bin = ComputeBinomialCoef(N - D);
    //Normalize Krawtchouk
    double *C;
    if ((C = (double *) malloc(sizeof ( double) * (N + 1))) == NULL) {
        printf("Cannot allocate C matrix memory\n");
        return NULL;
    }
    memset(C, 0.0, sizeof ( double) * (N + 1));

    if ((Kr = (double *) malloc(sizeof ( double) * (N + 1))) == NULL) {
        printf("Cannot allocate Krawtchouk vector memory\n");
        return NULL;
    }
    memset(Kr, 0.0, sizeof ( double) * (N + 1));

    for (i = 0; i < (N - D) + 1; i++) {
        Kr[i] = Bin[i];
    }

    double ant;
    double act;
    for (d = 1; d <= D; d++) {
        ant = Kr[0];
        for (i = 1; i < N + 1; i++) {
            act = Kr[i];
            Kr[i] = act - ant;
            ant = act;
        }
    }
    free(Bin);
    Bin = NULL;

    free(C);
    C = NULL;

    return Kr;
}

