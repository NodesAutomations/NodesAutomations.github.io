---
title: Analyse your data with python using pandas
description: learn how to use pandas package to clean up or analyze data using python
date: 15-02-2025
categories: [Python, Libraries]
tag: [python, excel, how to, library]
image: /assets/images/python/python-pandas.webp
published: false
---

### Overview
- In this tutorial, I'll show you how to use pandas package to manipulate your tabular data
- pandas library is open source and free to use and my favorite library to manipulate tabular data due it it's simple api
- In this tutorial i am going to focus on
  - Basic Data manipulation
  - Reading writing data from and to excel file


### Setup
- use `Pip install pandas` to install pandas package
  
### Basic Data manipulation
Create Data frame
```python
import pandas as pd
df=pd.DataFrame([[1,2,3],[4,5,6],[7,8,9]],index=["i","ii","iii"],columns=["A","B","C"])
df.head()
```

### Read data from file


