import numpy as np
import time
import sys
import os
from numpy import linalg as LA
from datetime import datetime

from sklearn.decomposition import NMF


def NMF_CV(data, cv_fold, max_k, max_l1Ratio):
    '''
    data --> input data must be in 2D (nsamples,nfeatures)
    cv_fold --> number of cross validation, example is 5 
    max_k --> maximum number of components
    max_l1Ratio --> maximum number of l1 
    
    '''
    
    # define space of k and l1Ratio
    error_mat, l1_space, k_space = error_space(max_k = max_k, max_l1Ratio = max_l1Ratio, 
                                                cv_fold = cv_fold)
    t0 = datetime.now()
    for i in range(len(l1_space)):
        for ii in range(len(k_space)):
            for iii in range(cv_fold):
                Out = fold_gen(data= data, cv_fold= cv_fold, k_num=iii)
                t1 = datetime.now()
                model = NMF(n_components=k_space[ii].astype(int),  max_iter=500, 
                               alpha=l1_space[i], l1_ratio=1.0)
                
                Wd = model.fit_transform(Out['D'])
                Hd = model.components_
                A_hat = A_Hat(Wd=Wd, Hd=Hd, B=Out['B'], C=Out['C'])
                error_mat[ii,i,iii] = error_cal(A=Out['A'], A_hat=A_hat)
                print('L1 alpha' ,l1_space[i],'Components ', k_space[ii] ,'Fold', iii, 'Error', 
                      (error_mat[ii,i,iii]),'T' , datetime.now()-t1)
    print('Total Time of run ', datetime.now()-t0)         

    # find best parameters to do zoom in 
    min_loc = np.array(np.where(np.mean(error_mat,axis=2) == np.min(np.mean(error_mat,axis=2))))
    print('Minimum Error location',min_loc)
    return error_mat, l1_space, k_space, min_loc


def fold_gen(data, cv_fold, k_num):
    # k_num must start from 0 
    OutPut = {}
    n, f = data.shape # get shape of input matrix
    n_space = np.floor(np.linspace(0,n,cv_fold + 1)).astype(int)
    f_space = np.floor(np.linspace(0,f,cv_fold + 1)).astype(int)
    # genratig submatrices A, B, C, D
    A = data[n_space[k_num]:n_space[k_num+1],f_space[k_num]:f_space[k_num+1]]
    B = data[n_space[k_num]:n_space[k_num+1],:]
    B = np.delete(B, np.arange(f_space[k_num],f_space[k_num+1]), axis=1)
    C = data[:,f_space[k_num]:f_space[k_num+1]]
    C = np.delete(C, np.arange(n_space[k_num],n_space[k_num+1]), axis = 0)
    D = np.delete(data,np.arange(f_space[k_num],f_space[k_num+1]), axis=1)
    D = np.delete(D, np.arange(n_space[k_num],n_space[k_num+1]), axis = 0)
    OutPut['A'] = A
    OutPut['B'] = B
    OutPut['C'] = C
    OutPut['D'] = D
    return OutPut

def error_space(max_k, max_l1Ratio, cv_fold):
    # prepare spcae of k and l1 ratio within each cv_fold
    if isinstance(max_k, int) | isinstance(max_k,float):
        k_space = np.floor(np.linspace(2,max_k,np.floor(np.sqrt(max_k)/2)))
        l1_space = np.linspace(.01,max_l1Ratio,4 * (max_l1Ratio/np.sqrt(max_l1Ratio)))
    else:
        
        k_space = max_k
        l1_space = max_l1Ratio
        
    cv_error = np.zeros((len(k_space),len(l1_space),cv_fold))
    return cv_error, l1_space, k_space

def error_cal(A, A_hat):
    
    return LA.norm(A-A_hat)

def A_Hat(Wd, Hd, B, C):
    
    #Wa = NNLS(A = Hd, b = B)
    #Ha = NNLS(A = Wd, b = C)
    return np.dot(np.dot(B,np.linalg.pinv(Hd)),np.dot(np.linalg.pinv(Wd),C))