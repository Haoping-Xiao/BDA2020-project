import matplotlib.pyplot as plt
import numpy as np

def visualizeData(data):
  year=list(range(2005,2020))
  plt.figure(figsize=(10,8))
  for i in range(len(data)):
    plt.plot(year,data[i],marker='.')
  plt.legend(['Metropolitan', 'Cumbria', 'Lancashire', 'Merseyside', 'Greater Manchester', 'Cheshire'])
  plt.title('Preprocessed Data')
  plt.xlabel('year')
  plt.ylabel('accident rates per 10,000 people')
  plt.savefig('../Figs/preprocessed_data.jpg')
  plt.show()

def fitData(data):
  plt.figure(figsize=(10, 8))
  years=list(range(2005,2020))
  for i in range(6):
      plt.scatter(years, data[i, :], marker='.', s=20)
      fit = np.polyfit(years, data[i, :], 1)
      fitted_values = np.polyval(fit, years)
      plt.plot(years, fitted_values)
  plt.title('Least squares polynomial fit to data')
  plt.legend(['Metropolitan', 'Cumbria', 'Lancashire', 'Merseyside', 'Greater Manchester', 'Cheshire'])
  plt.xlabel('year')
  plt.ylabel('accident rates per 10,000 people')
  plt.savefig('../Figs/fit_data.jpg')
  plt.show()
  


if __name__ == "__main__":
    with open('../Data/normalizedData.txt','r') as f:
      data=[[float(num) for num in line.split(' ')] for line in f]
    f.close()
    # visualizeData(data)
    fitData(np.array(data))