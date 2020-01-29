#include "matrixoper.h"

/* 
 * File:   matrixoper.c
 * Author: Alfonso Estudillo Romero <alfonsoer at gmail.com>
 *
 * Created on December 7, 2014, 12:53 AM
 * 
 * Description: 
 */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <memory.h>
#include "imagetypes.h"

/*Fast transpose algorithm*/
image_double_t transpose_double(image_double_t A) {
    int i, j;
    image_double_t B;
    B.data = NULL;
    B.H0 = 0;
    B.W0 = 0;

    if ((B.data = (double *) malloc(sizeof ( double) * (A.H0 * A.W0))) == NULL) {
        printf("Cannot allocate transpose matrix  memory\n");
        return B;
    }
    for (j = 0; j < A.H0; j++) {
        for (i = 0; i < A.W0; i++) {
            B.data[i * A.H0 + j] = A.data[j * A.W0 + i];
        }
    }
    B.H0 = A.W0;
    B.W0 = A.H0;
    return B;
}

/*Element by element multiplication of two matrices*/
image_double_t mult_element_by_element(image_double_t A, image_double_t B) {
    image_double_t C;
    int i, k, j;
    C.data = NULL;
    if ((A.W0 != B.W0) && (A.H0 != B.H0)) {
        printf("A.W0 = %d, A.H0 = %d, B.W0 = %d, B.H0 %d\n", A.W0, A.H0, B.W0, B.H0);
        printf("Matrix dimensions (height and width) do not agree (mult_element_by_element)\n");
        return C;
    }
    C.W0 = B.W0;
    C.H0 = B.H0;
    if ((C.data = (double *) malloc(sizeof ( double) * (A.H0 * B.W0))) == NULL) {
        printf("Cannot allocate product matrix  memory\n");
        return C;
    }

    for (i = 0; i < (C.H0 * C.W0); i++) {
        C.data[i] = A.data[i] * B.data[i];
    }
    return C;
}

/*Fast matrix product algorithm*/
image_double_t mult_double(image_double_t A, image_double_t B) {
    image_double_t C;
    int i, k, j;
    C.data = NULL;
    if (A.W0 != B.H0)
        return C;
    if ((C.data = (double *) malloc(sizeof ( double) * (A.H0 * B.W0))) == NULL) {
        printf("Cannot allocate product matrix  memory\n");
        return C;
    }
    C.W0 = B.W0;
    C.H0 = A.H0;

    memset(C.data, 0.0, sizeof ( double) * (C.H0 * C.W0));

    for (i = 0; i < A.H0; i++) {
        for (k = 0; k < A.W0; k++) {
            double aik = A.data[i * A.W0 + k];
            for (j = 0; j < B.W0; j++) {
                C.data[i * C.W0 + j] += aik * B.data[k * B.W0 + j];
            }
        }
    }
    return C;
}

