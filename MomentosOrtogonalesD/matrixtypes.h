/* 
 * File:   matrixtypes.h
 * Author: Alfonso Estudillo Romero <alfonsoer at gmail.com>
 *
 * Created on November 8, 2014, 5:31 PM
 * 
 * Description: This file defines different matrix types
 */

#ifndef MATRIXTYPES_H
#define	MATRIXTYPES_H

#ifdef	__cplusplus
extern "C" {
#endif
    /*
    #include <stdbool.h>

    struct matrix_bool_s {
        bool *data;
        unsigned int H0;
        unsigned int W0;
        unsigned int Size;
    };*/

    struct matrix_uchar_s {
        unsigned char *data;
        unsigned int H0;
        unsigned int W0;
        unsigned int Size;

    };

    struct matrix_int_s {
        int *data;
        unsigned int H0;
        unsigned int W0;
        unsigned int Size;

    };

    struct matrix_uint_s {
        unsigned int *data;
        unsigned int H0;
        unsigned int W0;
        unsigned int Size;

    };

    struct matrix_float_s {
        float *data;
        unsigned int H0;
        unsigned int W0;
        unsigned int Size;

    };

    struct matrix_double_s {
        double *data;
        unsigned int H0;
        unsigned int W0;
        unsigned int Size;

    };

    //Typedefs para matrices
 /*   typedef struct matrix_bool_s matrix_bool_t; */
    typedef struct matrix_uchar_s matrix_uchar_t;
    typedef struct matrix_int_s matrix_int_t;
    typedef struct matrix_uint_s matrix_uint_t;
    typedef struct matrix_float_s matrix_float_t;
    typedef struct matrix_double_s matrix_double_t;


#ifdef	__cplusplus
}
#endif

#endif	/* MATRIXTYPES_H */

