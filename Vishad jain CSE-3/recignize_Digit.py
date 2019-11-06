import matplotlib.pyplot as pt
import numpy as np
import pandas as pd
from sklearn.tree import DecisionTreeClassifier

data=pd.read_csv(r"C:\Users\VISHAD JAIN\PycharmProjects\digitrecog\train.csv").values
clf=DecisionTreeClassifier()

xtrain=data[0:1000,1:]
train_label=data[0:1000,0]

clf.fit(xtrain,train_label)

xtest=data[1000:,1:]
actual_label=data[1000:,0]

p=clf.predict(xtest)

count=0
for i in range(0,1000):
    count+=1 if p[i]==actual_label[i] else 0
print("Accuracy=",(count/1000)*100)
