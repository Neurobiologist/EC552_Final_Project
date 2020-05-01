import numpy as np
import pandas as pd

dataPoints = 100

lengthU = np.random.normal(20,1,dataPoints)
widthU = np.random.normal(10,1,dataPoints)
distanceU = np.random.normal(5,1,dataPoints)
electricField = np.random.normal(20,1,dataPoints)
voltage = np.random.normal(4.62,1,dataPoints)
flowRate = np.random.normal(140,1,dataPoints)
percentYield = np.random.normal(90,1,dataPoints)

data = np.column_stack((lengthU,widthU))
data = np.column_stack((data,distanceU))
data = np.column_stack((data,electricField))
data = np.column_stack((data,voltage))
data = np.column_stack((data,flowRate))
data = np.column_stack((data,percentYield))

pd.DataFrame(data).to_csv("test.csv", header = None, index = False)