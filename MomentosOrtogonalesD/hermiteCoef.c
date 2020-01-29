/*
 * File:   main.c
 * Author: Alfonso Estudillo Romero <alfonsoer at gmail.com>
 *
 * Created on April 10, 2015, 5:12 PM
 *
 * Description:
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "mex.h"
#include "matrixtypes.h"
#include "imagetypes.h"
#include "matrixoper.h"

#include "krawtchouk.h"
#include "statistics.h"

/*
 *
 */

int hermiteCoef(image_double_t im, double DiagCoef[], image_double_t *coeff, int option) {
    
    image_double_t Kr;
    image_double_t filtered;
    
    int i, j, d;
    int maxDx;
    int maxDy;
    int maxN;
    int MaxDecomposition;
    
    double sum, DiagSum;
    double mean;
    
    mean = getMean(im);
    /*subtract the mean*/
    for (i = 0; i < im.H0 * im.W0; i++) {
        im.data[i] = im.data[i] - mean;
    }
    
    /*Matrix of coefficients*/
    coeff->H0 = im.H0;
    coeff->W0 = im.W0;
    coeff->data = mxMalloc(sizeof ( double) * (coeff->W0)* (coeff->H0));
    memset(coeff->data, 0.0, sizeof ( double) * (coeff->W0)* (coeff->H0));
    
    if (im.H0 == im.W0) {
        MaxDecomposition = im.W0;
        maxN             = im.W0-1;
        for (i = 0; i < MaxDecomposition; i = i + 1) {
            if(option==1){
                printf("===========\n");
                printf("Derivative degree = %d\n", i);
            }
            maxDy = 0;
            DiagSum = 0.0;
            for (d = i; d >= 0; d = d - 1) {
                maxDx = d;
                if(option==1){printf("Dx = %d, Dy = %d\n", maxDx, maxDy);
                }
                Kr = Krawtchouk2DFilter(maxN, maxDx, maxDy);
                if (Kr.data != NULL) {
                    filtered = mult_element_by_element(im, Kr);
                    if (filtered.data != NULL) {
                        /*Get sum*/
                        sum = 0.0;
                        for (j = 0; j < (filtered.H0 * filtered.W0); j++) {
                            sum = filtered.data[j] + sum;
                        }
                        coeff->data[maxDy*(coeff->W0) + maxDx] = sum;
                        /*Add current coefficient to rotated sum*/
                        DiagSum = DiagSum + fabs(coeff->data[maxDy*(coeff->W0) + maxDx]);
                        if(option==1){printf("%.3e ", sum);}
                        /*Free Memory*/
                        free(filtered.data);
                        filtered.data = NULL;
                    }
                    /*Free Memory*/
                    free(Kr.data);
                    Kr.data = NULL;
                    if(option==1){printf("\n");}
                }
                maxDy = maxDy + 1;
            }
            DiagCoef[i] = DiagSum;
        }
    } else {
        printf("Image dimensions (height and width) do not agree\n");
    }
    if(option==1){printf("===========\n");}
}

/* The gateway function */
void mexFunction(int NumOutputArgs, mxArray *OutputData[],
        int NumInputArgs, const mxArray *InputData[])
{
    
    image_double_t im;   /* The input image */
    
    /* check for proper number of arguments */
    if(NumInputArgs<1) {
        mexErrMsgIdAndTxt("HermiteFilters:NumInputArgs","Not enough input arguments.");
    }
    if(NumInputArgs>2) {
        mexErrMsgIdAndTxt("HermiteFilters:NumInputArgs","Too many input arguments.");
    }
    if(NumOutputArgs<1){
        mexErrMsgIdAndTxt("HermiteFilters:NumOutputArgs","Not enough output arguments.");
    }
    if(NumOutputArgs>3){
        mexErrMsgIdAndTxt("HermiteFilters:NumOutputArgs","Too many output arguments.");
    }
    /* make sure the first input argument is type double */
    if( !mxIsDouble(InputData[0]) ||
            mxIsComplex(InputData[0])) {
        mexErrMsgIdAndTxt("HermiteFilters:notDouble","Input matrix must be type double.");
    }
    
    /* create a pointer to the real data in the input matrix  */
    im.data = mxGetPr(InputData[0]);
    /* get dimensions*/
    im.H0 = mxGetM(InputData[0]);
    im.W0 = mxGetN(InputData[0]);
    
    if(im.H0!=im.W0){
        mexErrMsgIdAndTxt("HermiteFilters:notDouble","Input matrix must be squared.");
    }
    
    /* get the value of the option. option==1 for verbose mode*/
    int option;
    if(NumInputArgs==2){
        option = mxGetScalar(InputData[1]);
        if(option==1){
            printf("Verbose mode ON\n");
        }
    }else{
        option=0;
    }
    
    
    image_double_t coeff;    /*Matrix of coefficients*/
    double *DiagCoef = NULL; /*Diagonal representing the sum of
     * coefficients of the same degree*/
    DiagCoef = mxMalloc(sizeof ( double)   * (im.W0));
    memset(DiagCoef, 0.0, sizeof ( double) * (im.W0));
    int i, j;
    
    /* C main code */
    hermiteCoef(im, DiagCoef, &coeff, option);
    
    /* Create a 0-by-0 mxArray; for posterior memory allocation */
    OutputData[0] = mxCreateNumericMatrix(0, 0, mxDOUBLE_CLASS, mxREAL);
    /* set a pointer to the real data in the output matrix */
    mxSetPr(OutputData[0], DiagCoef);
    mxSetM(OutputData[0], 1);
    mxSetN(OutputData[0], im.W0);
    
    /* If second output argument is present, then return coefficients */
    if(NumOutputArgs>=2){
        /* Create a 0-by-0 mxArray; for posterior memory allocation */
        OutputData[1] = mxCreateNumericMatrix(0, 0, mxDOUBLE_CLASS, mxREAL);
        /* set a pointer to the real data in the output matrix */
        mxSetPr(OutputData[1], coeff.data);
        mxSetM (OutputData[1], coeff.H0);
        mxSetN (OutputData[1], coeff.W0);
    }
}

