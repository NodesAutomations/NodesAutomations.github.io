---
title: Analyse your data with python using pandas
description: learn how to use pandas package to clean up or analyze data using python
date: 22-02-2025
categories: [Python, Libraries]
tag: [python, excel, how to, library]
image: /assets/images/python/python-pandas.webp
# published: false
---

### Overview
- In this tutorial, I'll show you how to use pandas package to manipulate your tabular data
- pandas library is open source and free to use and my favorite library to manipulate tabular data due it it's simple api
- In this tutorial i am going to focus on
  - Basic Data manipulation
  - Reading writing data from and to excel file


### Setup
- use `Pip install pandas` to install pandas package
- use `import pandas as pd` to import pandas package

### Create Dataframe

#### List
```python
df = pd.DataFrame([[1, 2, 3], [4, 5, 6], [7, 8, 9]], index=[
                  "i", "ii", "iii"], columns=["A", "B", "C"])
print(df)
```
```python
df = pd.DataFrame(
    [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9],
        [10, 11, 12],
        [13, 14, 15],
        [16, 17, 18],
        [19, 20, 21],
        [22, 23, 24],
        [25, 26, 27],
        [28, 29, 30]
    ],
    index=["i", "ii", "iii", "iv", "v", "vi", "vii", "viii", "ix", "x"],
    columns=["A", "B", "C"]
)
```
#### CSV File
```python
df = pd.read_csv('Column Data.csv')
```
#### Excel file
```python
df = pd.read_excel('Column Data.xlsx')
```
if you have multiple sheets then specify sheet name
```python
df = pd.read_excel('Column Data.xlsx', sheet_name="Data")
```

### Manipulation Dataframe

#### Print Data
print first/last 5 rows
```python
print(df.head())
print(df.tail())
```
if you want to print only first/last 2 rows
```python
print(df.head(2))
print(df.tail(2))
```
print only rowIndex or column Index
this is usefull to create dropdowns 
```python
print(df.index)
print(df.columns)
print(df["B"])
```
print specific row
```python
print(df.loc[0:2])
```
print specific value based on row and column index
```python
print(df.iat[0, 0])
print(df.iat[2, 1])
print(df.loc["i"]["A"])
# use Row and Column Name
print(df.loc["v", "B"])
```
you can also use this to update specific values
```python
df.loc["i"]["A"] = 100
print(df.loc["i"]["A"])
```
#### Sort Data
sort values by specific column
```python
print(df.sort_values(by=["A"]))
print(df.sort_values(by=["A"], ascending=False))

```
Filter using multiple columns
```python
print(df.sort_values(by=["A", "B"]))
```

#### Filter Data
filter by specific value
```python
print(df.loc[df["B"] > 10])
print(df.loc[df["DEPTH"] == 600])
print(df.loc[df["DEPTH"] > 600])
```

#### Clean up Data




### Write data to file

