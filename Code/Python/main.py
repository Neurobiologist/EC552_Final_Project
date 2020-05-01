# -*- coding: utf-8 -*-
"""
Created on Sat Dec  7 18:42:35 2019

@author: jadta
"""
import csv
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

data = pd.read_csv('data.csv', sep = ',', header = 0)
data = data.to_numpy()

testdata = pd.read_csv('test.csv', sep = ',', header = 0)
testdata = testdata.to_numpy()

train = data[:,:-1]
test = data[:,:-1]

testy = data[:,-1,np.newaxis]
testy = np.asarray(testy)

y = data[:,-1,np.newaxis]
y = np.asarray(y)

X = train

def add_column(X):
    n_ = X.shape[0]
    return np.concatenate([X,np.ones((n_,1))], axis = 1)

def predict(X, theta):
    X_prime = add_column(X)
    return np.dot(X_prime,theta)

def loss(X,y,theta):
    loss = ((predict(X,theta) - y)**2).mean()/2
    return loss

def loss_gradient(X, y, theta):
    X_prime = add_column(X)
    loss_grad = ((predict(X,theta)-y)*X_prime).mean(axis = 0)[:, np.newaxis]
    return loss_grad

def run_gd(loss, loss_gradient, X, y, theta_init, lr = 0.1, n_iter = 1000):
    theta_current = theta_init.copy()
    loss_values = []
    theta_values = []
    
    for i in range(n_iter):
        loss_value = loss(X, y , theta_current)
        theta_current = theta_current - lr*loss_gradient(X,y,theta_current)
        loss_values.append(loss_value)
        theta_values.append(theta_current)
        
    return theta_current, loss_values, theta_values

theta_init = np.zeros((X.shape[1] + 1, 1))
result = run_gd(loss, loss_gradient, X, y, theta_init, n_iter = 250, lr = 1e-6)
theta_est, loss_values, theta_values = result

p = plt.plot(loss_values)
plt.xlabel("iterations")
plt.ylabel("loss")
plt.show()

print("length: {}".format(+theta_est[1]))
print("width: {}".format(+theta_est[2]))
print("distance: {}".format(+theta_est[3]))
print("electricField: {}".format(+theta_est[4]))
print("voltage: {}".format(+theta_est[5]))
print("flowRate: {}".format(+theta_est[6]))

ybar = predict(test,theta_est)
summation = 0
for i in range(len(testy)):
    diff = testy[i] - ybar[i]
    squareddiff = diff**2
    summation = summation + squareddiff
MSE = summation/len(testy)

print("Error: {}".format(MSE))
        