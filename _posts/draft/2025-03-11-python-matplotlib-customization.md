---
title: Add extra visuals to matplotlib charts
description: learn how to add shapes and annotations to matplotlib charts
date: 11-03-2025
categories: [Python, Frameworks]
tag: [python, excel, how to, library]
image: /assets/images/python/python-matplotlib.webp
published: false
---

## Overview
- Adding visualization to existing charts can be great improvement to your chart
- By adding this visualization you can
  - highlight certain parts of the chart
  - add custom text annotations or markers to make chart easier to understand
  - create cross sections for you geometry
- I am assuming that you alraedy know basics of matplotlib, if not go through this post first : [Create charts using matplotlib](/posts/python-matplotlib/)


## Setup
- use `Pip install matplotlib` to install Matplotlib  package
- use `import matplotlib.pyplot as plt` to import

## Create Blank Chart
```python
```
#### Add Circle

#### Add Rectangle

#### Add Line

#### Add Polygon

#### Add Text

#### Add Dimension line

#### Final Version
```python
import matplotlib.pyplot as plt

# set plot size
plt.figure(figsize=(10, 10))

# Create blank plot
plt.axes()
ax = plt.gca()

# Set plot limits
ax.set_xlim([-100, 100])
ax.set_ylim([-100, 100])

# Add grid
ax.grid(linestyle='--')
ax.set_xticks(range(-100, 101, 100))
ax.set_yticks(range(-100, 101, 100))

# Circle without fill
circle = plt.Circle(xy=(-50, -50), radius=25,
                    color="b", fill=False, linewidth=4)
ax.add_patch(circle)

# Circle with transparency
circle2 = plt.Circle(xy=(-50, -50), radius=15, color="k", alpha=0.2)
ax.add_patch(circle2)

# Circle with fill
circle3 = plt.Circle(xy=(-50, -50), radius=5, color="r")
ax.add_patch(circle3)

# Rectangle without fill
rectangle = plt.Rectangle(xy=(25, -75), width=50,
                          height=50, color="g", fill=False, linewidth=4)

ax.add_patch(rectangle)

# Rectangle with transparency
rectangle2 = plt.Rectangle(xy=(25, -75), width=30,
                           height=30, color="k", alpha=0.2)
ax.add_patch(rectangle2)

# Rectangle with fill
rectangle3 = plt.Rectangle(xy=(25, -75), width=10,
                           height=10, color="r")
ax.add_patch(rectangle3)

# line
line = plt.Line2D(xdata=[25, 75], ydata=[90, 90],
                  color="r", linewidth=4)
ax.add_line(line)

# polygon without fill
polygon = plt.Polygon(xy=[(25, 25), (75, 25), (75, 75)],
                      color="b", fill=False, linewidth=4)
ax.add_patch(polygon)


# Annotations
plt.text(-90, 90, "Circle", fontsize=14, color="r")
# Dimension, Arrow
ax.annotate("", xy=(-90, 80), xytext=(-25, 80),
            arrowprops=dict(arrowstyle="->", color='black'))
ax.annotate("", xy=(-90, 75), xytext=(-25, 75),
            arrowprops=dict(arrowstyle="<->", color='black'))

# Display Plot
plt.tight_layout()
plt.show()
```
![Bar Chart](/assets/images/python/python-matplotlib-customization-1.webp)
_Screenshot 1 : Charts with shapes and annotations_

 
## Conclusion

## Resources
