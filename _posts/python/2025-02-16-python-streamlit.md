---
title: Create webapps using python and streamlit 
description: learn how to create webapp with python using streamlit framework
date: 16-02-2025
categories: [Python, Frameworks]
tag: [python, excel, how to, library]
image: /assets/images/python/python-streamlit.webp
---

### Overview
- In this tutorial, I'll show you how to use streamlit framework  to create webapps using python
- Streamlit 
  - It is open-source python framework to develop web apps with only few lines of code.
  - It allows user to host your webapps in the cloud completely free of cost
  - It solves one major pain point of python developers which is deployment
  - User don't need install anything on their system to use it, just open streamlit link and use it
- In this tutorial I am going to focus on
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
- Streamlit has multiple ways to display text, you have choose right element based on your requirement
- Streamlit has built-in support for markdown text (markdown is a simple way to add formatting to text in plain text format, google it)

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
- Note: use `r` before string to escape special characters in latex string

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
- `st.write()` is another way to display 
- Difference between `st.write()` and remaining text elements is that `st.write()` can take any python object as input while other only accepts string as input

```python
st.write("Hello, world!")
```

#### Divider
- To Separate group of elements

```python
st.divider()
```

### Tabular Data Elements

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
### Trigger Elements

#### Simple button
- we have 3 types of buttons in streamlit, Button formatting is automatically selected based on button type
  - primary : background color is the app primary color
  - secondary :background is the app background color
  - tertiary : displayed as plain text without any color or border

```python
if st.button("Say, Hello.", type="primary"):
    st.write("Hello, World!")
```
#### Download file button
```python

@st.cache_data
def convert_df(df):
    # IMPORTANT: Cache the conversion to prevent computation on every rerun
    return df.to_csv().encode("utf-8")

df = pd.DataFrame([[1, 2, 3], [4, 5, 6], [7, 8, 9]], index=[
    "i", "ii", "iii"], columns=["A", "B", "C"])
st.table(df)

csv = convert_df(df)
st.download_button(
    label="Download data as CSV",
    data=csv,
    file_name="Data.csv",
    mime="text/csv",
)
```

### Input Elements

#### Basic inputs
- Get String input from user

```python
name: str = st.text_input("Enter your name", placeholder="Type your first name...")
st.write(f"Hello, {name}.")
```

- Get whole number input from user

```python
# Import datetime library for this example
current_year: int = datetime.now().year
birthYear: int = st.number_input("Enter your birth year", min_value=1900, max_value =current_year, value =1990,step = 1)
```

- Get Decimal input from user

```python
number:float = st.number_input("Insert a number")
st.write("The current number is ", number)
```

#### Large Text 
```python
text_data = st.text_area("Text Data", "Write some text here", height=100)
st.write(text_data)
```
#### Check Box
```python
is_Okay_With_Terms = st.checkbox("I accept all the terms and conditions")

if is_Okay_With_Terms:
    st.write("You can proceed further")
else:
    st.write("You cannot proceed further")
```

#### Radio Button
```python
language: str = st.radio(
    "What's your favorite programming language?",
    ["Python", "CSharp", "VBA"],
    captions=[
        "Best for General Purpose",
        "Best for Corporate Projects",
        "Best for Office Automation",
    ],
)

st.write("You selected:", language)
```

#### Dropdown
```python
concrete_grade = st.selectbox(
    "Choose Concrete Grade",
    ("M35", "M40", "M45", "M50"),
)

st.write("You selected:", concrete_grade)
```

#### Multi Select
```python
options = ["North", "East", "South", "West"]
selection = st.pills("Directions", options, selection_mode="multi")
st.markdown(f"Your selected options: {selection}.")
```
```python
options = ["North", "East", "South", "West"]
selection = st.segmented_control(
    "Directions", options, selection_mode="multi"
)
st.markdown(f"Your selected options: {selection}.")
```
```python
options = st.multiselect(
    "What are your favorite colors",
    ["Green", "Yellow", "Red", "Blue"],
    ["Yellow", "Red"],
)
st.markdown(f"Your selected options: {options}.")
```

#### File Input
- Default file size limit is 200MB, which is more than enough for most users
- It can also have option to accept multiple files to do that set parameter `accept_multiple_files=True`

```python
# Import Pandas as pd
csv_file = st.file_uploader("Choose a CSV file", type="csv")
if csv_file is not None:
    # Read the CSV file
    df = pd.read_csv(csv_file)

    # Display the contents of the CSV file
    st.write(df)
```

### Conclusion
- Streamlit is a very good framework to create web apps using python it has it's pros and cons
- Pros
  - It has almost all UI elements that you'll ever need to create webapps
  - Great Documentation and Community Support 
  - You can build web apps with only few lines of code
- Cons
  - If your app requires interactivity with other apps like extracting data from AutoCAD or STAAD then it's not possible with streamlit
  - UI is rigid, you can't customize it to your needs, can't add your company logo


> If you have any questions or want to discuss something : [Join our comment section](https://www.reddit.com/r/NodesAutomations/comments/1isc5g2/create_webapps_using_python_and_streamlit_nodes/)
{: .prompt-info }