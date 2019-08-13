import numpy as np

import h5py

from skimage.transform import resize

from datetime import datetime


def readData(Add,size,test_train_ratio,normalized,shuffle):
    '''
    Add --> address of data location, data structure is based on Brain_data
    size --> only number of frame we want to choose(third dimension)
    test_train_ratio --> Ration of train from data with selected size, must be between 0 and 1
    shuffle --> Shuffle data in random form or no, only True or False
    normalized --> normalized data, reduce mean and divide by std
    '''
    File = h5py.File(Add)
    data = File['Data']
    data = np.array(data[0:size])
    Label = File['Label']
    Label = np.array(Label[0:size])
    print('Original Data size ',data.shape, ' Orignal Label size ',Label.shape)
    # dividing data to train and test 
    if test_train_ratio>1 and test_train_ratio<=0:
        assert('Oops, test_train_ration is not correct')
    Train_num = np.int(size*test_train_ratio)
    Test_num = size - Train_num
    if Test_num<0 and Train_num<0:
        assert('Something is wrong with Test_Train ratio or data size. Train or test size is negative')
    if normalized:
        data = data - np.mean(data,axis=0)
        data = np.divide(data,np.std(data,axis=0))
        if np.any(np.isnan(data)):
            assert('Data has Nan after normalization')
    # squeeze label to 1D vector
    LL = np.zeros(data.shape[0])
    ind1 = np.where(Label[:,0]==1) # silent
    ind2 = np.where(Label[:,1]==1) # movement
    ind3 = np.where(Label[:,2]==1) # transition
    LL[ind1] = 0
    LL[ind2] = 1
    LL[ind3] = 2
    LL.astype('int32')
    print('Label 0 is Silent, 1 is movement, 2 is transition')
    
    if shuffle:
        Shuff = np.random.permutation(data.shape[0])
        FullData = data[Shuff,:,:]
        FullLabel = LL[Shuff]
    else:
        FullData = data
        FullLabel = LL
    train_data = FullData[0:Train_num,:,:]
    print('Train data size ',train_data.shape)
    test_data = FullData[Train_num:Train_num + Test_num ,:,:]
    print('Test data size ',test_data.shape)

    train_label = FullLabel[0:Train_num].astype(int)
    print('Train label size ', train_label.shape)
    test_label = FullLabel[Train_num:Train_num + Test_num ].astype(int)
    print('Test label size ', test_label.shape)
    return train_data, train_label, test_data, test_label