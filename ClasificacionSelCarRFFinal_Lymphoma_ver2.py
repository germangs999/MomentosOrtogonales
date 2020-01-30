#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jun  7 19:22:37 2018

@author: german
"""

import pandas as pd
import numpy as np
import scipy as sp
from scipy import signal, io
import matplotlib.pyplot as plt
from sklearn.model_selection import cross_val_score
from sklearn.metrics import f1_score, accuracy_score, mean_squared_error
from sklearn.svm import SVC, SVR
#from sklearn.tree import DecisionTreeClassifier
#from sklearn.ensemble import BaggingRegressor, BaggingClassifier
#from sklearn.tree import ExtraTreeClassifier
#from sklearn.ensemble import AdaBoostRegressor,AdaBoostClassifier
from sklearn.ensemble import GradientBoostingRegressor, GradientBoostingClassifier
from sklearn.ensemble import RandomForestRegressor, RandomForestClassifier
#from xgboost import XGBClassifier
from sklearn.naive_bayes import GaussianNB, BernoulliNB, MultinomialNB
from sklearn.neighbors import KNeighborsClassifier
from sklearn.feature_selection import RFECV
import hdf5storage
import time
import warnings
warnings.filterwarnings(module='sklearn*', action='ignore', category=DeprecationWarning)

grupos  = 5
np.random.seed(32)
#n_est = 100

#Estimador para la seleccion de caracteristicas
estimador_selector = RandomForestClassifier()
selector_rfecv = RFECV(estimador_selector, n_jobs=-1)

lista_bases = ['Lymphoma']
lista_fam = ['S', 'T', 'K', 'D']

tiempo = np.zeros(shape=(1))

for indice_lst in lista_bases:
    for indice_fam in lista_fam:
    
        nombre_base = indice_lst+'_Caracteristicas'+indice_fam+'.mat'
        Datos = hdf5storage.loadmat(nombre_base) 
        
        if indice_fam == 'S':
            Caracteristicas = Datos['CaracteristicasS']     
        elif indice_fam == 'T':
            Caracteristicas = Datos['CaracteristicasT']
        elif indice_fam == 'K':
            Caracteristicas = Datos['CaracteristicasK']
        else:
            Caracteristicas = Datos['CaracteristicasD']
            
        etiqueta = Datos['etiquetas']
        etiquetas = etiqueta.reshape((etiqueta.shape[0]))
        
        Resultados = np.zeros(shape=(4,5))
        ResultadosSTD = np.zeros(shape=(4,5))
        ResultadosCompletos = np.zeros(shape=(4,5,grupos))
        start_time = time.time()
    
        for vent in range(4): 
            desc=1
            Caracteristicas_vent = Caracteristicas['vent'][0,desc][0,vent]#[0,desc,0,vent] 
            
            Car_dff = pd.DataFrame(Caracteristicas_vent)    
            Car_df = selector_rfecv.fit_transform(Car_dff, etiquetas)
    
            
############ KNN
            clasificador_knn = KNeighborsClassifier(n_neighbors=10, weights="uniform")           
            accuracy_knn = cross_val_score(clasificador_knn, X=Car_df, y=etiquetas, scoring='accuracy', 
                            cv=grupos, n_jobs = -1)
            ResultadosCompletos[vent, 0,:] =accuracy_knn
            Resultados[vent, 0] = accuracy_knn.mean()
            ResultadosSTD[vent, 0] = accuracy_knn.std()
            
########### maquina de soporte lineal 
            estimador_svm_lineal = SVC(kernel="linear")
            accuracy_SVM_lineal = cross_val_score(estimador_svm_lineal, X=Car_df, y=etiquetas, scoring='accuracy', 
                                        cv=grupos, n_jobs = -1)
            ResultadosCompletos[vent, 1,:] =accuracy_SVM_lineal
            Resultados[vent, 1] = accuracy_SVM_lineal.mean()
            ResultadosSTD[vent, 1] = accuracy_SVM_lineal.std()
            
############Estimador SVM
            estimador_svm =  SVC()
            accuracy_SVM = cross_val_score(estimador_svm, X=Car_df, y=etiquetas, scoring='accuracy', 
                            cv=grupos, n_jobs = -1)
            ResultadosCompletos[vent, 2,:]= accuracy_SVM
            Resultados[vent, 2] = accuracy_SVM.mean()
            ResultadosSTD[vent, 2] = accuracy_SVM.std()
            
            n_est = Car_df.shape[1]
############RANDOM FOREST
            estimador_randomforest = RandomForestClassifier(n_estimators=n_est)
            accuracy_randomforest = cross_val_score(estimador_randomforest, X=Car_df, y=etiquetas, scoring='accuracy', 
                                       cv=grupos, n_jobs=-1)

            ResultadosCompletos[vent, 3,:] =accuracy_randomforest
            Resultados[vent, 3] = accuracy_randomforest.mean()
            ResultadosSTD[vent, 3] = accuracy_randomforest.std()
            
############Clasificadores Bayesianos
            #Gaussiano
            estimador_Bayes_g =  GaussianNB()
            accuracy_Bayes_g = cross_val_score(estimador_Bayes_g, X=Car_df, y=etiquetas, scoring='accuracy', 
                            cv=grupos, n_jobs = -1)
            
            ResultadosCompletos[vent, 4,:] = accuracy_Bayes_g
            Resultados[vent, 4] = accuracy_Bayes_g.mean()
            ResultadosSTD[vent, 4] = accuracy_Bayes_g.std()  


############3

        tiempo[0] = time.time() - start_time 
         
        io.savemat('Resultados'+ indice_fam +'_SelCarRF_' + indice_lst + '.mat', {'Resultados': Resultados, 'ResultadosSTD': ResultadosSTD, 
                                                     'tiempo' : tiempo, 'ResultadosCompletos': ResultadosCompletos})  
