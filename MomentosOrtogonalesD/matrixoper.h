/* 
 * File:   matrixoper.h
 * Author: Alfonso Estudillo Romero <alfonsoer at gmail.com>
 *
 * Created on December 7, 2014, 12:53 AM
 * 
 * Description: 
 */

#ifndef MATRIXOPER_H
#define	MATRIXOPER_H

#include <string.h>
#include "imagetypes.h"

#ifdef	__cplusplus
extern "C" {
#endif
    
image_double_t transpose_double(image_double_t A);
image_double_t mult_double(image_double_t A, image_double_t B);
image_double_t mult_element_by_element(image_double_t A, image_double_t B);


#ifdef	__cplusplus
}
#endif

#endif	/* MATRIXOPER_H */

