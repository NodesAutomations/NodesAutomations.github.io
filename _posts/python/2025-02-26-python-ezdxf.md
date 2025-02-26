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
  - no dependensy on windows so you can use it on any operating system or web apps like streamlit
  - In Active development with really good documentation
  - [Documentation](https://ezdxf.readthedocs.io/)
- Requirements
  - python 3.9 or higher


## Setup
- use `Pip install ezdxf` to install xlwings package

## Write new dxf file

#### Create new dxf file
- Copy the below code and run it to generate dxf file with circle
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

- By Default dxf file is save in current directory
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
#### Hatch
```python
hatch = msp.add_hatch(color=ezdxf.colors.RED)
hatch.set_pattern_fill("ANSI31", scale=0.5)
hatch.paths.add_polyline_path(
    [(0, 0), (100, 0), (100, 100), (0, 100)], is_closed=True
)
```

## Read Data from Dxf file