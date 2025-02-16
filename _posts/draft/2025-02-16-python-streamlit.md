---
title: Create webapp with python using streamlit 
description: learn how to create webapp with python using streamlit framework
date: 16-02-2025
categories: [Python, Libraries]
tag: [python, excel, how to, library]
image: /assets/images/python/python-pandas.webp
# published: false
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
st.text("This is a text")
st.markdown("This is a **markdown** text")
```
- st.write() is another way to display 
- Difference between st.write() and remaining text elements is that st.write() can take any python object as input while other only accepts string as input

```python
st.write("Hello, world!")
```

### Input Elements

#### Basic inputs
```python
name: str = st.text_input("Enter your name", "Vivek")
st.write(f"Hello, {name}.")
```
