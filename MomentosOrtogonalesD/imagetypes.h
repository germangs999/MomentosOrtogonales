/* 
 * File:   imagetypes.h
 * Author: Alfonso Estudillo Romero <alfonsoer at gmail.com>
 *
 * Created on November 8, 2014, 5:36 PM
 * 
 * Description: This file defines different image types based on the matrix tupes
 */

#ifndef IMAGETYPES_H
#define	IMAGETYPES_H

#include "matrixtypes.h"

#ifdef	__cplusplus
extern "C" {
#endif

    //Typedefs para imagenes
/*    typedef struct matrix_bool_s   image_bool_t; */
    typedef struct matrix_uchar_s  image_uchar_t;
    typedef struct matrix_int_s    image_int_t;
    typedef struct matrix_uint_s   image_uint_t;
    typedef struct matrix_float_s  image_float_t;
    typedef struct matrix_double_s image_double_t;

#ifdef	__cplusplus
}
#endif

#endif	/* IMAGETYPES_H */

