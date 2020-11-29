import pandas as pd
import numpy as np
def extractData1(rawData,startYear,endYear,filename):
  #only extract date and district data 
  data=rawData[['Date','Local_Authority_(District)']]
  num=5 # extract 5 districts
  extractedData=np.zeros((num,(endYear-startYear+1)))
  for i in range(num):
    district=data.loc[data['Local_Authority_(District)']==(i+1)]
    for year in range(startYear,endYear+1):
      accidentNum=district[district['Date'].str.contains(str(year))].shape[0]
      extractedData[i,(year-startYear)]=accidentNum
  np.savetxt(filename,extractedData.astype(int),fmt='%i')


def extractData2(rawData,startYear,endYear):
  #
  scale=10000
  population=np.array([8961989,500012,1508941,1429910,2835686,1066647])/scale
  
  #only extract date and Police_Force data
  data=rawData[['Date','Police_Force']]
  Police_Forces=[1,3,4,5,6,7] # extract 5 Police_Force
  extractedData=np.zeros((len(Police_Forces),(endYear-startYear+1)))
  for i,Police_Force in enumerate(Police_Forces):
    district=data.loc[data['Police_Force']==Police_Force]
    for year in range(startYear,endYear+1):
      accidentNum=district[district['Date'].str.contains(str(year))].shape[0]
      extractedData[i,(year-startYear)]=accidentNum/population[i]
  return extractedData


def extractData(path,filename):
  rawData=pd.read_csv('./Data/Accidents0515.csv')
  oldData=extractData2(rawData,2005,2015)
  data2016=pd.read_csv('./Data/Accidents_2016.csv')
  # print(list(data2016))
  # print(data2016.dtypes)
  data2017=pd.read_csv('./Data/Accidents_2017.csv')
  # print(list(data2017))
  # print(data2017.dtypes)
  data2018=pd.read_csv('./Data/Accidents_2018.csv')
  # print(list(data2018))
  # print(data2018.dtypes)
  data2019=pd.read_csv('./Data/Accidents_2019.csv')
  # print(list(data2019))
  # print(data2019.dtypes)
  data=[data2016,data2017,data2018,data2019]
  dataframe=pd.concat(data,axis=0,ignore_index=True)
  newData=extractData2(dataframe,2016,2019)
  # print(oldData.shape)
  # print(newData.shape)
  data=np.hstack((oldData,newData))
  np.savetxt(path+filename,data.astype(float),fmt='%.2f')
  return data


if __name__ == "__main__":
  extractData('./Data/','normalizedData.txt')