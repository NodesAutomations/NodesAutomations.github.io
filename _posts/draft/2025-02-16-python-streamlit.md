---
title: Create webapp with python using streamlit 
description: learn how to create webapp with python using streamlit framework
date: 16-02-2025
categories: [Python, Libraries]
tag: [python, excel, how to, library]
image: /assets/images/python/python-pandas.webp
published: false
---

### Overview
- In this tutorial, I'll show you how to use streamlit package to create webapps using python
- Streamlit 
  - It is open-source python framework to develop webapps with only few lines of code.
  - It allows user to host your webapps in the cloud completely free of cost
  - It solves one major pain point of python developers which is deployment
  - User don't need install anything on their system to use it, just open streamlit link and use it
- In this tutorial i am going to focus on
  - Getting inputs from user
  - Display output in form of text, table, charts, images

### Setup
- use `Pip install streamlit` to install pandas package
- create `StartUp.py` file with content from below code block
- run command `streamlit run startup.py` to generate webapp
- this will generate your webapp and start local server 
- open local URL in browser to check out your webapp
- now add sample code of input or output elements to build your webapp

```python
# startup.py
import streamlit as st
st.write("# Streamlit Demo") 

# you can copy paste any code from below code block to see how that element works
```

### Display Elements

#### Text Elements
- Streamlit have mutiple ways to display text, you have choose right element based on your requirement
- Streamlit have built-in support for markdown text (markdown is a simple way to add formatting to text in plain text format, google it)
```python
st.title("Welcome to Streamlit")
st.header("This is a header")
st.subheader("This is a subheader")
st.text("This is a text")
st.text("Main Text", help="Add your description here.")
st.markdown("This is a **markdown** text")
```

#### Caption
```python
st.caption("This is a caption")
```

#### Code
```python
code = '''def hello():
    print("Hello, World!")'''
st.code(code, language="python")
```
#### Latex
- Note: use r before string to escape special characters in latex string

```python
st.latex(r'a^2 + b^2 = c^2')
```
#### HTML
- html tags are good way to add some custom elements to your webapp 

```python
st.html(
    """
    <div style="text-align: center; margin-top: 20px;">
        <a href="https://nodesautomations.com/" target="_blank" style="
            display: inline-block;
            padding: 10px 20px;
            border: 1px solid #007bff;
            border-radius: 5px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            font-family: Arial, sans-serif;
        ">
           Nodes Automations
        </a>
    </div>
    """
)
```

#### All in one
- st.write() is another way to display 
- Difference between st.write() and remaining text elements is that st.write() can take any python object as input while other only accepts string as input

```python
st.write("Hello, world!")
```

#### Divider
- To Separate group of elements

```python
st.divider()
```

### Tablular Data

#### Static Table
- Import pandas using  `import pandas as pd` 

```python
df = pd.DataFrame([[1, 2, 3], [4, 5, 6], [7, 8, 9]], index=[
                  "i", "ii", "iii"], columns=["A", "B", "C"])
st.table(df)
```

#### Interactive Table
- Import Pandas and Numpy

```python
df = pd.DataFrame(np.random.randn(50, 20), columns=(
    "col %d" % i for i in range(20)))

st.dataframe(df)  # Same as st.write(df)
```

### Input Elements

#### Basic inputs
```python
name: str = st.text_input("Enter your name", "Vivek")
st.write(f"Hello, {name}.")
```
