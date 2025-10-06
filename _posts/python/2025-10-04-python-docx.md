---
title: Generate Word Report using python-docx
description: Learn how to use the python-docx package to automate Word .docx files
date: 02-10-2025
categories: [Python, Python-Libraries]
tag: [python, autocad, how to, library, autocad-python]
image: /assets/images/python/python-docx.webp
---

## Overview
- python-docx is:
  - open source, so you can use it for free
  - independent of Office; you can generate .docx files even if Office is not installed on your system
  - cross-platform, so you can use it on any operating system or web apps like Streamlit
  - in active development with really good documentation
  - [Documentation](https://python-docx.readthedocs.io/)
- Requirements
  - Python 3.9 or higher


## Setup
- Use `pip install python-docx` to install the python-docx package

## Write new docx file
```python
from docx import Document

# Create new Word Document
document = Document()

# Add Code to Generate Document Content Here

# Save Document to specific location
document.save("Report.docx")
```
Use existing document for custom formatting
```python
document = Document("Template.docx")
```
#### Title
```python
# Add Title
document.add_heading("Automated Report", 0)
```
#### Header
```python
# Add Header 1
document.add_heading("Header 1", level=1)

# Add Header 2
document.add_heading("Header 2", level=2)

# Add Header 3
document.add_heading("Header 3", level=3)
```
#### Paragraph
```python
# Add a paragraph
document.add_heading("Paragraph", level=3)
P = document.add_paragraph("This is a sample paragraph in the report.")

# Add more text to the same paragraph
P.add_run("This text is added to the same paragraph.")

# Paragraph formatting
P = document.add_paragraph("This is paragraph with Center Alignment, ")
P_format = P.paragraph_format
P_format.alignment = WD_ALIGN_PARAGRAPH.CENTER  # Center alignment

# Paragraph with space before and after
P = document.add_paragraph("This is paragraph with space before and after.")
P_format = P.paragraph_format
P_format.space_after = Pt(24)  # Space after paragraph
P_format.space_before = Pt(24)  # Space before paragraph

# Paragraph with Different Left Indent
P = document.add_paragraph("This is paragraph with Custom Left Indent.")
P_format = P.paragraph_format
P_format.left_indent = Pt(36)  # Left indent

# Paragraph with different font and size
P = document.add_paragraph("This is paragraph with Arial Font with size 12.")
P_font = P.runs[0].font
P_font.name = "Arial"  # Font name
P_font.size = Pt(12)  # Font size

# Paragraph with Different Underline Style
P = document.add_paragraph("This is paragraph with Underline Style Double.")
P_font = P.runs[0].font
P_font.underline = True  # Underline text
P_font.underline = WD_UNDERLINE.DOUBLE  # Underline style
```

#### Text Formatting
```python
# Add Bold Text
P = document.add_paragraph("This is paragraph with bold text.")
P.add_run(" Adding Bold Text Here.").bold = True

# Add Italic Text
P = document.add_paragraph("This is paragraph with Italic Text.")
P.add_run(" Adding Italic Text Here.").italic = True

# Add Text with underline
P = document.add_paragraph("This is paragraph with Underlined Text.")
P.add_run(" Adding Underlined Text Here.").underline = True

# Add Text with Red Color
P = document.add_paragraph("This is paragraph with Red Color Text.")
P.add_run(" Adding Red Color Text Here.").font.color.rgb = RGBColor(255, 0, 0)

# Add Text with Yellow Highlight Color
P = document.add_paragraph("This is paragraph with Yellow Highlight Color Text.")
P.add_run(" Adding Yellow Highlight Here.").font.highlight_color = WD_COLOR_INDEX.YELLOW

# Add Text With Different Font
P = document.add_paragraph("This is paragraph with Verdana Font Text.")
P.add_run(" Adding Verdana Font Text Here.").font.name = "Verdana"

# Add Text with Different Font Size
P = document.add_paragraph("This is paragraph with 16 font size Text.")
P.add_run(" Adding 16 font size Text Here.").font.size = Pt(16)

# Adding Text with Different Text Style Subtle Emphasis
P = document.add_paragraph("This is paragraph with Subtle Emphasis Text.")
P.add_run(" Adding text with subtle emphasis.").style = "Subtle Emphasis"
```

```python
# Apply Multiple Formattings
P = document.add_paragraph()
Line = P.add_run("This is paragraph with Bold, Italic and Underlined Text.")
Line.bold = True
Line.italic = True
Line.underline = True
```
#### Bullet List
```python
# Add a bullet list
document.add_heading("Bullet List", level=3)
document.add_paragraph("First item in unordered list", style="List Bullet")
document.add_paragraph("Second item in unordered list", style="List Bullet")
document.add_paragraph("Third item in unordered list", style="List Bullet")
```

#### Numbered List
```python
# Add a numbered list
document.add_heading("Numbered List", level=3)
document.add_paragraph("First item in ordered list", style="List Number")
document.add_paragraph("Second item in ordered list", style="List Number")
document.add_paragraph("Third item in ordered list", style="List Number")
```

#### Formula
- python-docx doesn't have built-in support for LaTeX formulas.
- We'll use the math2docx library to add formulas.
- Use `pip install math2docx` to install the math2docx library.
- Add `import math2docx` to include math formulas.
  
```python
# Adding Text with formula
document.add_heading("Formula", level=3)
P = document.add_paragraph()
latex_ = r"BM = \frac{w \times l^2}{8}"
math2docx.add_math(P, latex_)
```

#### Quote
```python
# Add Quote
document.add_heading("Quote", level=3)
P = document.add_paragraph("This is just a sample quote.")
P.style = "Intense Quote"
```
#### Image
- Import the Inches class using `from docx.shared import Inches`

```python
# Add Image chart.png
document.add_heading("Images", level=3)
document.add_picture("chart.png", width=Inches(5))
```

#### Table
```python
document.add_heading("Simple Table", level=3)
records = (
    (7, "22.1", "25.5"),
    (14, "26.9", "31.2"),
    (21, "28.5", "35.2"),
    (28, "30.9", "40.0")
)

table = document.add_table(rows=1, cols=3)

# Header Row
hdr_cells = table.rows[0].cells
hdr_cells[0].text = "Days"
hdr_cells[1].text = "M30 Strength"
hdr_cells[2].text = "M40 Strength"

# Data Rows
for qty, id, desc in records:
    row_cells = table.add_row().cells
    row_cells[0].text = str(qty)
    row_cells[1].text = id
    row_cells[2].text = desc

# Set Table style to Table Grid
table.style = "Table Grid"

# Set First row as Bold
for cell in table.rows[0].cells:
    for paragraph in cell.paragraphs:
        for run in paragraph.runs:
            run.bold = True

# Set Center alignment for all columns
for col in table.columns:
    for cell in col.cells:
        cell.paragraphs[0].alignment = 1
```
#### PageBreak
```python
# Add Page Break
document.add_page_break()
```

## Final Code
```python
import math2docx
from docx import Document
from docx.shared import Inches, RGBColor, Pt
from docx.enum.text import WD_ALIGN_PARAGRAPH, WD_UNDERLINE, WD_COLOR_INDEX

# Create new Word Document
document = Document()

# Add Title
document.add_heading("Automated Report", level=0)

# Add Header 1
document.add_heading("Header 1", level=1)

# Add Header 2
document.add_heading("Header 2", level=2)

# Add Header 3
document.add_heading("Header 3", level=3)

# Add a paragraph
document.add_heading("Paragraph", level=3)
P = document.add_paragraph("This is a sample paragraph in the report.")

# Add more text to the same paragraph
P.add_run("This text is added to the same paragraph.")

# Paragraph formatting
P = document.add_paragraph("This is paragraph with Center Alignment, ")
P_format = P.paragraph_format
P_format.alignment = WD_ALIGN_PARAGRAPH.CENTER  # Center alignment

# Paragraph with space before and after
P = document.add_paragraph("This is paragraph with space before and after.")
P_format = P.paragraph_format
P_format.space_after = Pt(24)  # Space after paragraph
P_format.space_before = Pt(24)  # Space before paragraph

# Paragraph with Different Left Indent
P = document.add_paragraph("This is paragraph with Custom Left Indent.")
P_format = P.paragraph_format
P_format.left_indent = Pt(36)  # Left indent

# Paragraph with different font and size
P = document.add_paragraph("This is paragraph with Arial Font with size 12.")
P_font = P.runs[0].font
P_font.name = "Arial"  # Font name
P_font.size = Pt(12)  # Font size

# Paragraph with Different Underline Style
P = document.add_paragraph("This is paragraph with Underline Style Double.")
P_font = P.runs[0].font
P_font.underline = True  # Underline text
P_font.underline = WD_UNDERLINE.DOUBLE  # Underline style


document.add_page_break()
document.add_heading("Text Formatting", level=2)

# Add Bold Text
P = document.add_paragraph("This is paragraph with bold text.")
P.add_run(" Adding Bold Text Here.").bold = True

# Add Italic Text
P = document.add_paragraph("This is paragraph with Italic Text.")
P.add_run(" Adding Italic Text Here.").italic = True

# Add Text with underline
P = document.add_paragraph("This is paragraph with Underlined Text.")
P.add_run(" Adding Underlined Text Here.").underline = True

# Add Text with Red Color
P = document.add_paragraph("This is paragraph with Red Color Text.")
P.add_run(" Adding Red Color Text Here.").font.color.rgb = RGBColor(255, 0, 0)

# Add Text with Yellow Highlight Color
P = document.add_paragraph(
    "This is paragraph with Yellow Highlight Color Text.")
P.add_run(
    " Adding Yellow Highlight Here.").font.highlight_color = WD_COLOR_INDEX.YELLOW

# Add Text With Different Font
P = document.add_paragraph("This is paragraph with Verdana Font Text.")
P.add_run(" Adding Verdana Font Text Here.").font.name = "Verdana"

# Add Text with Different Font Size
P = document.add_paragraph("This is paragraph with 16 font size Text.")
P.add_run(" Adding 16 font size Text Here.").font.size = Pt(16)

# Adding Text with Different Text Style Subtle Emphasis
P = document.add_paragraph("This is paragraph with Subtle Emphasis Text.")
P.add_run(" Adding text with subtle emphasis.").style = "Subtle Emphasis"


# Apply Multiple Formattings
P = document.add_paragraph()
Line = P.add_run("This is paragraph with Bold, Italic and Underlined Text.")
Line.bold = True
Line.italic = True
Line.underline = True

document.add_page_break()
document.add_heading("Text Styles", level=2)

# Add a bullet list
document.add_heading("Bullet List", level=3)
document.add_paragraph("First item in unordered list", style="List Bullet")
document.add_paragraph("Second item in unordered list", style="List Bullet")
document.add_paragraph("Third item in unordered list", style="List Bullet")

# Add a numbered list
document.add_heading("Numbered List", level=3)
document.add_paragraph("First item in ordered list", style="List Number")
document.add_paragraph("Second item in ordered list", style="List Number")
document.add_paragraph("Third item in ordered list", style="List Number")

# Adding Text with formula
document.add_heading("Formula", level=3)
P = document.add_paragraph()
latex_ = r"BM = \frac{w \times l^2}{8}"
math2docx.add_math(P, latex_)

# Add Quote
document.add_heading("Quote", level=3)
quote = document.add_paragraph(
    "The greatest glory in living lies not in never falling, "
    "but in rising every time we fall.")
quote.style = "Intense Quote"

# Add Hyperlink
document.add_heading("Hyperlink", level=3)
P = document.add_paragraph("This is a paragraph with a ")


# Add Page Break
document.add_page_break()

# Add Table
document.add_heading("Tables", level=2)

# Simple Table
document.add_heading("Simple Table", level=3)
records = (
    (7, "22.1", "25.5"),
    (14, "26.9", "31.2"),
    (21, "28.5", "35.2"),
    (28, "30.9", "40.0")
)

table = document.add_table(rows=1, cols=3)

# Header Row
hdr_cells = table.rows[0].cells
hdr_cells[0].text = "Days"
hdr_cells[1].text = "M30 Strength"
hdr_cells[2].text = "M40 Strength"

# Data Rows
for qty, id, desc in records:
    row_cells = table.add_row().cells
    row_cells[0].text = str(qty)
    row_cells[1].text = id
    row_cells[2].text = desc

# Set Table style to Table Grid
table.style = "Table Grid"

# Set First row as Bold
for cell in table.rows[0].cells:
    for paragraph in cell.paragraphs:
        for run in paragraph.runs:
            run.bold = True

# Set Center alignment for all columns
for col in table.columns:
    for cell in col.cells:
        cell.paragraphs[0].alignment = 1

document.add_page_break()
document.add_heading("Media", level=2)

# Add Image chart.png
document.add_heading("Images", level=3)
document.add_picture("chart.png", width=Inches(5))

# Save Document to specific location
document.save("Report.docx")
```

## Conclusion
- The python-docx library is one of the simplest ways to generate Word reports using Python.
- You can also use an existing document with your own styles and formatting to maintain your custom style