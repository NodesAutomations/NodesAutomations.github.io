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
- use `import matplotlib.pyplot as plt` to import


## Line Chart
- for sample data i am using Concrete Test Data for M30 Grade Concrete for 7/14/21/28 days

```python
import matplotlib.pyplot as plt

# Data for M30 concrete strength
days = [7, 14, 21, 28]
strength_M30 = [22.1, 26.9, 28.5, 30.9]

# Create new plot using matplotlib
plt.plot(days, strength_M30)

# Display Plot
plt.show()
```
- So that's bare minimum code for you to generate a line chart using matplotlib
- Now let's try to add more visuals to our chart by going through few variations
- Also I am only going to show modified part of code for rest of variation so you have to add import statement ,data by yourself

#### Adding multiple lines
```python
# Data for M30 concrete strength
days = [7, 14, 21, 28]
strength_M30 = [22.1, 26.9, 28.5, 30.9]
strength_M40 = [25.2, 31.2, 35.2, 40.0]

# Create new plot using matplotlib
plt.plot(days, strength_M30)
plt.plot(days, strength_M40)
```
#### Adding Labels
```python
# Create new plot using matplotlib
plt.plot(days, strength_M30)
plt.plot(days, strength_M40)

# Add Title
plt.title("Compressive Strength Data")
plt.xlabel("Days")
plt.ylabel("Strength (MPa)")
```
#### Adding Legends
- Manually enter legend names in sequence of your plot lines

```python
plt.legend(["M30", "M40"])
```
- You can also mention legend with plot itself

```python
plt.plot(days, strength_M30, label="M30")
plt.plot(days, strength_M40, label="M40")

plt.legend()
```

#### Line formatting
- A format string `[marker][line][color]` consists of a part for color, marker and line
- [Format Strings Docs](https://matplotlib.org/stable/api/_as_gen/matplotlib.pyplot.plot.html#matplotlib.pyplot.plot)
- Adding Color

```python
# green line
plt.plot(days, strength_M30, color="g" , label="M30")
# red line
plt.plot(days, strength_M40, color="r" , label="M40")
# using hex value for red color
plt.plot(days, strength_M40, color="#FF0000", label="M40")
```

- Adding Line Style

```python
# dashed line
plt.plot(days, strength_M30 , linestyle="--", label="M30")
# dotted line
plt.plot(days, strength_M40, linestyle=":", label="M40")
```

- Adding Line Width

```python
plt.plot(days, strength_M30, linewidth=2, label="M30")
plt.plot(days, strength_M40, linewidth=4, label="M40")
```

- Adding marker

```python
# triangle marker
plt.plot(days, strength_M30, marker="^", label="M30")
# circle marker
plt.plot(days, strength_M40, marker="o", label="M40")
```

#### Plot style
- you need to add this at start of your plot code
- you can find list of available styles from [Using Style sheets](https://matplotlib.org/stable/users/explain/customizing.html#using-style-sheets)

```python
plt.style.use("fivethirtyeight")
```
## Bar Chart

## Conclusion
