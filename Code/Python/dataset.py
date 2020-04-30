import numpy as np
import pandas as pd

lengthU = np.random.normal(20,1,100)
widthU = np.random.normal(10,1,100)
distanceU = np.random.normal(5,1,100)
electricField = np.random.normal(20,1,100)
voltage = np.random.normal(4.62,1,100)
flowRate = np.random.normal(140,1,100)
percentYield = np.random.normal(90,1,100)

data = np.column_stack((lengthU,widthU))
data = np.column_stack((data,distanceU))
data = np.column_stack((data,electricField))
data = np.column_stack((data,voltage))
data = np.column_stack((data,flowRate))
data = np.column_stack((data,percentYield))
pd.DataFrame(data).to_csv("test.csv", header = None, index = False)