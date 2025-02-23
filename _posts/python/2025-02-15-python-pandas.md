---
title: Analyse your data with python using pandas
description: learn how to use pandas package to clean up or analyze data using python
date: 22-02-2025
categories: [Python, Libraries]
tag: [python, excel, how to, library]
image: /assets/images/python/python-pandas.webp
---

### Overview
- In this tutorial, I'll show you how to use pandas Library to manipulate your tabular data
- Pandas Library is open source and free to use and my favorite library to manipulate tabular data due it it's simple API
- In this tutorial I am going to focus on
  - Basic Data manipulation
  - Reading writing data from and to excel file


### Setup
- use `Pip install pandas` to install pandas package
- use `import pandas as pd` to import pandas package
- i am also going to use csv file and excel file which contain column data from below table
- you can copy paste data from this table and create your own version

| ID  | BREATH | DEPTH |
| --- | ------ | ----- |
| C1  | 750    | 400   |
| C2  | 900    | 400   |
| C3  | 1050   | 400   |
| C4  | 830    | 630   |
| C5  | 1285   | 400   |
| C6  | 600    | 600   |
| C7  | 1200   | 400   |
| C8  | 800    | 400   |
| C9  | 900    | 600   |
| C10 | 750    | 300   |

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
print(df[df["B"] > 10])
print(df[df["DEPTH"] == 600])
print(df[df["DEPTH"] > 600])
```
filter but only show specific columns
```python
print(df[df["B"] > 10, ["A", "C"]])
```
filter by multiple conditions
```python
print(df[(df["BREATH"] > 600) & (df["DEPTH"] > 400)])
```

### Write data to file
#### CSV file
```python
df.to_csv("data.csv", index=True)
```
#### Excel file
```python
df.to_excel("data.xlsx", index=True)
```
### Conclusion
- pandas is a very useful library to manipulate tabular data
