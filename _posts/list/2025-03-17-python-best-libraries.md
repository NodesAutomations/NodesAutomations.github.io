---
title: 📖 Best Python Libraries and Frameworks for civil engineers 2025
description: learn about pros and cons of each library or framework
date: 17-03-2025
categories: [Developer Tools and Resources, Programming]
tag: [list, python, library]
image: /assets/images/best/python-best-libraries.webp
---

<!--#### pyrevit -->
<!--#### Quarto -->
<!--#### CustomTkinter  -->
<!--#### PyQt5   -->
<!--#### Nuitka -->
<!--#### pynite -->

## Overview
- In this post I am going to explain popular libraries and frameworks used by civil engineers
- All pros and cons are written from perspective of civil engineers
- Python has lot of libraries and frameworks, it's not feasible for me try all of them so i am going to focus on only those which I’ve used personally
- Basic Requirements for Library/framework
  - Free to use
  - Active Development
  - Good Documentation
  - Community Support
- I'll willing to let go of this basic requirements if there's no alternative available for that package or framework
- This post is still work in progress due to my limited exposure to python, feel free to send me suggestions or corrections if you find any

## Frameworks
- it's system to build apps from scratch
- Think of it as template of working program that we can modify as per our needs
- Frameworks provide skeleton for your app with reusable components and ready to use elements
- Benefits 
  - Reduces development time by Reusable components and ready to use elements
  - Allow us to focus on business logic and features, rather than building everything from scratch

#### [Streamlit](https://docs.streamlit.io/)
- What is it?
  - It's framework which allows us to create webapps using python
- Pros
  - Require very less code to build webapps
  - Lots of UI elements are available to get input from user or display outputs 
  - It allows user to host your webapps in the cloud completely free of cost
- Cons
  - Not suitable for interactive apps, means if i want to build app which will can interact with excel, AutoCAD or FEM software then it's not possible with streamlit
  - Can be slow if you have lot of calculation in your app, 98% of app will run fine with streamlit I am only talking about rare cases when you need to process large amount of data
- What do I think about it?
  - Streamlit solve one major issue I have with python which is deployment
  - You can just build your automation, deploy it on free community server and share it with your clients or users. Users don't need to install anything on their system to use it, just open streamlit link and use it.   

#### [Jupyter Notebook](https://jupyter.org/documentation)
- What is it?
  - It's not pure framework or library it's combination of both. I am going to keep this in frameworks group to keep it simple
  - Jupyter Notebook allows us to build interactive notebook using python, similar to excel but all input-output and calculations are done using python
- Pros
  - It's great for calculation when you need to see how's particular calculation is done
- Cons
  - Difficult to share it with others, user will require full python+jupyternotebook+Libraries to use it
- What do I think about it?
  - As programmer I find it bit hard write code
  - It's best suited for design calculation when you need to see how's particular calculation is done


#### [Viktor](https://docs.viktor.ai/)
- What is it?
  - It's platform to build web apps using python
- Pros
  - Exclusively focus on engineering applications
  - Have most of UI elements to take input or display output
  - Free hosting for public apps
  - Option to integrate your web app with local software like excel, AutoCAD, REVIT, STAAD, ETABS 
  - Option to build private apps with secure login 
- Cons
  - Paid subscription to use it for private apps
- What do I think about it?
  - It's best and only option when you want to build interactive web apps 
  - It's proprietary software and can change its Terms anytime so if you're okay with this then go for it
  - I've only build simple calculator app using it so still yet to try its full potential, specially integration with other software
  - Platform is still pretty new so i don't know how well it's integration with other software will work over long time but i have high hopes for it
  - Additionally this integration with other software also require python setup with all required libraries and Viktor setup for that particular software on user system which can be a bit tricky. This can also undermine whole point of using webapps for integration with other software.
  
## Data Manipulation Libraries

#### [Pandas](https://pandas.pydata.org/docs/)
- What is it?
  - Library to analyze and manipulate your tabular data
- Pros
  - Easy to use Data Structure using `Dataframe` and `Series`
  - Supports sorting, filtering, aggregation, and manipulation of data
  - Optimized to work with large Datasets
  - Currently in active development with good documentation and community support
  - Compatible with everything be it local app or web app(Streamlit) or Interactive notebook(Jupyter notebook)
- Cons
  - Steeper learning curve for beginners due to complex API
- What do I think about it?
  - It's an essential tool when working with tabular data, there's no alternative to it
  - it's my go to choice for data analysis and manipulation with python

<!-- #### NumPy -->
<!-- #### scipy -->
  
## Excel Libraries

#### [xlWings](https://docs.xlwings.org/)
- What is it?
  - Library to read/modify/write excel file 
- Pros
  - Simple to use API with good documentation
  - Can work with active excel file
  - Currently in active development, with good community support
- Cons
  - Require Excel installation on your system
- What do I think about it?
  - This is my favorite library to read/modify/write excel file
  - only reason to not use it if you don't have excel or want to build webapp

#### [openpyxl](https://openpyxl.readthedocs.io/)
- What is it?
- Pros
  - No dependency on Excel, so you can use it on any computer
  - Currently in active development
- Cons
  - Lack functionality compared to xlWings
- What do I think about it?
  - I prefer xlWings over openpyxl due to it's simple API and functionality
  - I only use this library with streamlit webapps since it's os independent and don't require any excel installation

## AutoCAD Libraries

#### [ezDxf](https://ezdxf.readthedocs.io/)
- What is it?
  - library to read/write/modify dxf file
- Pros
  - Simple to use API with good documentation
  - No dependency on AutoCAD, so you can use it on any computer
  - Currently in active development, so will get more features and fixes with time
- Cons
  - Can't work with AutoCAD drawings, we have to convert it to dxf first
- What do i think about it?
  - It's my current favorite library to generate drawings via python
  - It covers 80-90% of the stuff most projects require

#### [pyautocad](https://pyautocad.readthedocs.io/)
- What is it?
  - library to manipulate AutoCAD drawings
- Pros
  - it can directly work with Active AutoCAD drawings
- Cons
  - not in active development, last commit was in 2016
  - Bad Documentation so not suitable for beginners
- What do I think about it?
  - I prefer ezDxf over pyautocad
  - if really need to automate drawings, then ezDxf is best option
  - If you really want to interact with AutoCAD then go with VBA or C#

## Data Visualization Libraries

#### [Matplotlib](https://matplotlib.org/stable/index.html)
- What is it?
  - library for creating static, animated, and interactive visualizations in Python
- Pros
  - Provide full control over all aspects of a plot from colors and labels to tick marks
  - Option to add annotations like shapes, text, lines, and arrows to plot for better understanding
  - Compatible with almost all type of python apps be it local app, web app(Streamlit) or Interactive notebook(Jupyter notebook)
  - integrates well with libraries like NumPy, Pandas, and SciPy
  - In Active development with good documentation
- Cons
  - not a major con but compared to plotly it requires more code or less interactive 
- What do I think about it?
  - it's my go to library for adding charts to my python apps
  - might require more code for complex plots but it's not major issue for me
  - It's perfect for static charts due to its quality and customization options

#### [Plotly](https://plotly.com/python/getting-started/)
- What is it?
  -  library for creating interactive visualizations
- Pros
  - In Active development with good documentation
  - Highly Interactive,  Users can zoom, pan, hover, and click on data points without additional configuration
  - Compatible with almost all types of python apps be it local app, web app(Streamlit) or Interactive notebook(Jupyter notebook)
- Cons
  - Limited customization option compared to matplotlib
- What do I think about it?
  - I prefer plotly over matplotlib when user needs to interact with data for detail analysis 

<!-- ## GUI Libraries -->

## Civil Engineering
- Only general purpose libraries will be included
- For Libraries in specific domain like structural/geotech i'll create separate blog for that

#### [HandCalc](https://github.com/connorferster/handcalcs)
- What is it?
  -  library to render Python calculation code automatically in Latex
- Pros
  -  Displays calculations in a hand-written style, improving clarity and readability
  -  Perfect for teaching or documentation
- Cons
  - Only meant to work with Jupyter notebooks so limited use case
- What do I think about it?
  - It's my go to tool for design calculations using python with Jupyter notebook
  - great tool to create readable reports with calculations and equations

#### [forallpeople](https://github.com/connorferster/forallpeople)
- What is it?
  - Library to do units-aware calculations in python
- Pros
  - create very readable code with units
  - units are automatically calculated for return values
- Cons
  - no cons for now
- What do I think about it?
  - my preferred tool for doing unit sensitive calculation in python
  - Using this with handcalculation library is a great combination for engineering reports

## Miscellaneous

#### [comtypes](https://comtypes.readthedocs.io/en/stable/)
- What is it?
  - it's python package which will allow you to use VBA API calls using python
- Pros
  - Provide workaround for python development for older software which don't have any official python API
  - Open source with good documentation
- Cons
  - It's really hard to debug if you bump into any unknown error
  - No access to IntelliSense of class and modules make it very easy to make mistakes in code
- What do I think about it?
  - It's good enough for personal projects which don't require complex functionality
  - I always prefer to use official API for my clients for more stability and long term support


## Conclusion
- Python has lot of libraries and frameworks, it's easy to get confused or feel overwhelmed by them. 
- Hopefully my blog will guide you to choose library based on specific needs
- This is just first working version, I’ll try to add more categories with each revision


> If you have any questions or want to discuss something : [Join our comment section](https://www.reddit.com/r/NodesAutomations/comments/1jeqztv/best_python_libraries_and_frameworks_for_civil/)
{: .prompt-info }
