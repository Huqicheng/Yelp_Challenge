from dao import *
import numpy as np
from sklearn.linear_model import LinearRegression,ARDRegression
from sklearn.isotonic import IsotonicRegression
from sklearn import ensemble
import matplotlib.pyplot as plt

def linear_regression(data_x,data_y):
    lr = LinearRegression()
    lr.fit(data_x,data_y)
    predict_x = np.array(range(0,data_x.shape[0]))
    predict_x = np.reshape(predict_x,(data_x.shape[0],1))
    return predict_x,lr.predict(predict_x)

def ard_regression(data_x,data_y):
    clf = ARDRegression(compute_score=True)
    clf.fit(data_x, data_y)
    predict_x = np.array(range(0,data_x.shape[0]))
    predict_x = np.reshape(predict_x,(data_x.shape[0],1))
    return predict_x,clf.predict(predict_x)

def gbdt_regression(data_x,data_y):
    params = {'n_estimators': 40, 'max_depth': 4, 'min_samples_split': 2,
        'learning_rate': 0.01, 'loss': 'ls'}
    clf = ensemble.GradientBoostingRegressor(**params)
    clf.fit(data_x, data_y)
    y_ = clf.predict(data_x)
    return data_x,clf.predict(data_x)


'''
    lower 1,2
    higher 4
'''



def fetch_trend_data(id):
    result_list = get_review_by_businessid(id)
    return result_list

def preprocess_for_2d(result_list,interval):
    n_sample = len(result_list)
    if n_sample % interval != 0:
        n_sample-=n_sample%interval
    data_x = np.zeros((n_sample/interval,1))
    data_y = np.zeros((n_sample/interval,1))
    idx=1
    sample=0
    sum = 0.0
    for date,stars in result_list:
        if idx % interval == 0:
            data_x[sample,0] = sample
            data_y[sample,0] = sum/interval
            sample+=1
            sum=0.0
        idx+=1
        sum+=float(stars)
    
    return data_x,data_y

def preprocess_for_1d(result_list,interval):
    n_sample = len(result_list)
    if n_sample % interval != 0:
        n_sample-=n_sample%interval
    data_x = np.zeros((n_sample/interval,))
    data_y = np.zeros((n_sample/interval,))
    idx=1
    sample=0
    sum = 0.0
    for date,stars in result_list:
        if idx % interval == 0:
            data_x[sample] = sample
            data_y[sample] = sum/interval
            sample+=1
            sum=0.0
        idx+=1
        sum+=float(stars)
    
    return data_x,data_y


def run(business_id,interval):
    result_list = fetch_trend_data(business_id)
    data_x,data_y = preprocess_for_2d(result_list,interval)
    predicted_x,predicted_y = gbdt_regression(data_x,data_y)
    x = [sx  for sx in data_x]
    y = [sy  for sy in data_y]
    pred_x = [predx for predx in predicted_x]
    pred = [predy for predy in predicted_y]
    p = plt.subplot(1,1,1)
    p.plot(x, y, 'b-')
    p.plot(pred_x,pred,'g.-',markersize=12)
    p.set_ylabel('average stars')
    p.set_xlabel('days')
    p.set_title('ratings of business '+str(business_id))
    
    predicted_x,predicted_y = linear_regression(data_x,data_y)
    
    pred_x = [predx[0] for predx in predicted_x]
    pred = [predy[0] for predy in predicted_y]
    p.plot(pred_x,pred,'r-')
    
    plt.legend(['truth','gbdt','linear_regression'])
    
    plt.savefig('business'+str(business_id)+'.png')

if __name__ == '__main__':
    
    run('-0qht1roIqleKiQkBLDkbw',10)






