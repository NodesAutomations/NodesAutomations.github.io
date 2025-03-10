---
title: Create charts using matplotlib
description: learn how to create charts using matplotlib
date: 10-03-2025
categories: [Python, Frameworks]
tag: [python, excel, how to, library]
image: /assets/images/python/python-matplotlib.webp
published: false
---

## Overview
- Matplotlib is 
  - library for creating static, animated, and interactive visualizations in Python
  - you can use it with jupyter notebook or with web apps like streamlit
  - In Active development with good documentation
  - Open source with good [Documentation](https://matplotlib.org/stable/index.html)
- Requirements
  - python 3.10 or later
- Matplotlib  have ridiculous amount of features, it's not feasible for me to cover all of them so I am going to focus on only those which I’ve used personally, I'll add more variations and chart types in future


## Setup
- use `Pip install matplotlib` to install Matplotlib  package
- i am using streamlit to run this sample code but you can use jupyter notebook
- for data I’ve generated Concrete Test Data for M30 Grade Concrete
- sample code is given below to load this data using pandas, `Pip install pandas` to install pandas package

```python
import pandas as pd

# Concrete Compressive Strength Test Data for 10 samples of M30 Grade Concrete
# Each sample have 4 results for 7/14/21/28 days
data = []
data.append([22.1, 26.9, 28.5, 30.9])
data.append([21.8, 26.5, 28.2, 30.6])
data.append([22.5, 27.1, 28.8, 31.0])
data.append([21.6, 26.3, 28.0, 30.5])
data.append([22.3, 27.0, 28.6, 30.8])
data.append([21.9, 26.6, 28.3, 30.7])
data.append([22.0, 26.8, 28.4, 30.9])
data.append([21.7, 26.4, 28.1, 30.6])
data.append([22.2, 26.9, 28.7, 31.1])
data.append([21.5, 26.2, 27.9, 30.4])

# Create DataFrame
df = pd.DataFrame(data, columns=["7D", "14D", "21D", "28D"])
```
## Predefine Charts

#### Column Chart Using series

#### Column Chart using DataFrame

#### Line Chart Using series

#### Line Chart using DataFrame


## Conclusion
