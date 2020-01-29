/* 
 * File:   krawtchouk.h
 * Author: Alfonso Estudillo Romero <alfonsoer at gmail.com>
 *
 * Created on December 4, 2014, 3:38 AM
 * 
 * Description: 
 */

#ifndef KRAWTCHOUK_H
#define	KRAWTCHOUK_H
 #include "imagetypes.h"
 
#ifdef	__cplusplus
extern "C" {
#endif

    struct Kr_s {
        image_double_t Filt;
        int N;
        int Dx;
        int Dy;
    };
    typedef struct Kr_s Kr_t;

    //Defines a structure of a set of Krawtchouk filters
    struct kr_set_s {
        Kr_t *Kr;
        int NFilters;
        int maxDx;
        int maxDy;
    };
    typedef struct kr_set_s kr_set_t;


    double *ComputeKrawtchouk(int N, int D);
    image_double_t Krawtchouk2DFilter(int N, int Dx, int Dy);
    kr_set_t CreateKrawtchoukSet(int N, int MaxDx, int MaxDy);
    void printKrawtchoukFilter(image_double_t Kr);
    //Defines a structure of a Krawtchouk filter


#ifdef	__cplusplus
}
#endif

#endif	/* KRAWTCHOUK_H */

