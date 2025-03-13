---
title: Automate dxf file with Python & ezdxf
description: learn how to use ezdxf package to automate dxf file
date: 26-02-2025
categories: [Python, Libraries]
tag: [python, autocad, how to, library,autocad-python]
image: /assets/images/python/python-ezdxf.webp
---

## Overview
- ezdxf is 
  - open source so you can use it for free
  - no dependency on AutoCAD, so you can use it on any computer
  - no dependency on windows so you can use it on any operating system or web apps like streamlit
  - In Active development with really good documentation
  - [Documentation](https://ezdxf.readthedocs.io/)
- Requirements
  - python 3.9 or higher


## Setup
- use `Pip install ezdxf` to install xlwings package

## Write new dxf file

#### Create new dxf file
- Copy the code below and run it to generate dxf file with circle
- we are using `(0,0)` for point inputs

```python
import ezdxf

# create a new DXF
doc = ezdxf.new()

# get model space
msp = doc.modelspace()

# add circle to model space
circle = msp.add_circle((0, 0), 10)

# save the DXF document
doc.saveas("output.dxf")
```
> Make sure that output.dxf file is not open while running this script. We won't be able to write dxf file while it is open.
{: .prompt-info }

#### Document
- you can pass specific dxf version with new function

```python
doc = ezdxf.new()
doc = ezdxf.new(dxfversion="R2010")
doc = ezdxf.new(dxfversion="R2013")
```

- By Default, dxf file is save in current directory
- you can also save it in specific location by passing path

```python
doc.saveas("Output.dxf")
doc.saveas(r"C:\Users\Ryzen2600x\Downloads\Output.dxf")
```
#### Layer
- make sure to add layer before you start adding new entities to dxf file
- you can also pass LineType, LineWeight and Transparancy to add method
- use can use `dxfattribs` parameter to assign layer to specific entity like shown in circle example below

```python
# Create a new layer with color 1 (red)
doc.layers.add("REINFOCEMENT", color=ezdxf.colors.RED)
```
#### LineType
- Predefine Line Type
- add linetypes Import `from ezdxf.tools.standards import linetypes`

```python
# define paramters for linetype
lineTypeName = "CENTERLINE"
lineTypePatternName = "CENTER"
lineTypeDiscription = ""
lineTypePattern = ""

# Loop through lineTypesList to find the linetype with DASHDOT value as the first item
for linetype in linetypes():
    if linetype[0] == lineTypePatternName:
        lineTypeDiscription = linetype[1]
        lineTypePattern = linetype[2]
        break

if lineTypeName not in doc.linetypes:
    doc.linetypes.add(lineTypeName, lineTypePattern,
                      description=lineTypeDiscription)
```

- For Custom Line Type, you have to manually define pattern, as shown below
  - here 2 pattern length
  - 1.25 and -0.25 is for first dash
  - 1.25 and -0.25 is for second dash

```python
if "CENTERLINE" not in doc.linetypes:
    doc.linetypes.add(name='CENTERLINE', pattern=[
                      2.0, 1.25, -0.25, 1.25, -0.25])
```

#### Transparency
- you can set transparency of entity between 0 and 1
- 0 means fully opaque
- 1 means fully transparent

```python
# Draw circle in 0 layer
circle = msp.add_circle((0, 0), 10)
circle.transparency = 0.5
```
#### Entity dxf attributes
```python
# Draw circle with red color
circle = msp.add_circle((0, 0), 100, dxfattribs={"color": color=ezdxf.colors.RED})

# Draw circle with specific layer
circle = msp.add_circle((0, 0), 100, dxfattribs={"layer": "REINFOCEMENT"})
circle = msp.add_circle((0, 0), 100, dxfattribs={"layer": "REINFOCEMENT", "color": color=ezdxf.colors.YELLOW})
```

## Sample codes

#### Circle
```python
# Draw circle in 0 layer
circle = msp.add_circle((0, 0), 10)
```

#### Line
```python
line = msp.add_line((0, 0), (100, 100))
```

#### Polyline
```python
points = [(0.0, 0.0)]
points.append((100, 0))
points.append((100, 100))
points.append((0, 100))

msp.add_lwpolyline(points)
```

#### Text
```python
text = msp.add_text("Hello,World.", height=50, rotation=45)
text.set_placement((100, 100), align=ezdxf.enums.TextEntityAlignment.CENTER)
```

#### MText
```python
mtext = msp.add_mtext("Hello,World.")
mtext.set_location((100, 100), rotation=45)
```

#### Arc
```python
arc = msp.add_arc(center=(0, 0), radius=100, start_angle=0, end_angle=90)
```
#### Ellipse
```python
ellipse = msp.add_ellipse(center=(0, 0), major_axis=(
    100, 0), ratio=0.5)

ellipse = msp.add_ellipse(center=(0, 0), major_axis=(
    100, 0), ratio=0.5, start_param=math.pi/2, end_param=math.pi)
```
#### Linear Dimension
```python
msp.add_line((0, 0), (10, 10))
dim = msp.add_linear_dim(
    base=(5, 15),  # location of the dimension text
    p1=(0, 0),  # Start point
    p2=(10, 10),  # End point
    dimstyle="Standard",
    text="L=<>",
)
dim.render()# Don't Skip this
```
#### Aligned Dimension
```python
msp.add_line((0, 0), (10, 10))
dim = msp.add_aligned_dim(
    p1=(0, 0),  # Start point
    p2=(10, 10),  # End point
    distance=2,
    dimstyle="Standard",
    text="L=<>",
)
dim.render()  # Don't Skip this
```

#### Angular Dimension
```python
dim = msp.add_angular_dim_cra(
    center=(5, 5),  # center point of the angle
    radius=7,  # distance from center point to the start of the extension lines
    start_angle=60,  # start angle in degrees
    end_angle=120,  # end angle in degrees
    distance=3,  # distance from start of the extension lines to the dimension line
    dimstyle="Standard",  # default angular dimension style
)
dim.render()  # Don't Skip this
```
```python
arc = msp.add_arc(
    center=(0, 0),
    radius=5,
    start_angle=60,
    end_angle=120,
)
dim = msp.add_angular_dim_arc(
    arc.construction_tool(),
    distance=2,
)
dim.render()  # Don't Skip this
```

#### Leader
```python
leader = msp.add_leader(
    vertices=[(0, 0), (10, 10), (20, 10)],
    dimstyle="Standard"
)
```
#### MultiLeader
```python
ml_builder = msp.add_multileader_mtext("Standard")
ml_builder.quick_leader(
    f"angle={45}°\n2nd text line",# Content
    target=Vec2(0, 0),# Start Point
    segment1=Vec2(20, 20), # End Point Relative to Start
)
```
#### Hatch
```python
hatch = msp.add_hatch(color=ezdxf.colors.RED)
hatch.set_pattern_fill("ANSI31", scale=0.5)
hatch.paths.add_polyline_path(
    [(0, 0), (100, 0), (100, 100), (0, 100)], is_closed=True
)
```

## Conclusion
- ezdxf is a great package due to
  - Good documentation
  - Active Development
  - No dependency on AutoCAD
- If you don't need any interactive with AutoCAD, this is great package to use


> If you have any questions or want to discuss something : [Join our comment section](https://www.reddit.com/r/NodesAutomations/comments/1ja76y7/automate_dxf_file_with_python/)
{: .prompt-info }