---
title: Best Packages and Frameworks for Python 2025
description: learn about pros and cons of each library or framework
date: 25-02-2025
categories: [Developer Tools and Resources,Programming]
tag: [list, python, library]
image: /assets/images/python/python-streamlit.webp
published: false
---

## Overview
- In this post i am going to explain most of popular libraries and frameworks used by civil engineers
- All pros and cons are written from perspective of civil engineers
- Python has lot of libraries and frameworks, it's not feasible for me try all of them so i am going to focus on only those which i've used personally
- Basic Requirements for Library/framework
  - Free to use
  - Active Development
  - Good Documentation
  - Community Support

## Frameworks
- it's system to build apps from scratch
- Think of it as template of working program that we can modify as per our needs
- Framework provide skeleton for your app with reusable components and ready to use elements
- Benefits 
  - Reduces development time by Reusable components and ready to use elements
  - Allow us to focus on business logic and features, rather than building everything from scratch

#### Streamlit
- What is it?
  - It's framework which allows us to create webapps using python
- Pros
  - Require very less code to build webapps
  - Lots of UI elements are available to get input from user or display outputs 
  - It allows user to host your webapps in the cloud completely free of cost
- Cons
  - Not suitable for interactive apps, means if i want to build app which will can interact with excel, autocad or FEM software then it's not possible with streamlit
  - Can be slow if you have lot of calculation in your app, 98% of app will run fine with streamlit i am only talking about rare cases when you need to process large amount of data
- What do i think about it?
  - Streamlit solve one major issue i have with python which is deployment
  - You can just build your automation, deploy it on free commnity server and share it with your clients or users. User don't need to install anything on their system to use it, just open streamlit link and use it.   

#### Jupyter Notebook
- What is it?
  - It's not pure framework or library it's combination of both. I am going to keep this in frameworks group to keep it simple
  - Jupyter Notebook allows us to build interactive notebook using python, similar to excel but all input-output and calculations are done using python
- Pros
  - It's great for calculation when you need to see how's perticular calculation is done
- Cons
  - Difficult to share it with others, user will require full python+jupyternotebook+Libraries to use it
- What do i think about it?
  - As programmer i find it bit hard write code
  - It's best suited for design calculation when you need to see how's perticular calculation is done


#### Viktor
- What is it?
- Pros
- Cons
- What do i think about it?

## Data Manipulation Libraries

#### Pandas
- What is it?
- Pros
- Cons
- What do i think about it?
#### numpy
- What is it?
- Pros
- Cons
- What do i think about it?

#### scipy
- What is it?
- Pros
- Cons
- What do i think about it?
  
## Excel Libraries

#### xlWings
- What is it?
  - Library to read/modify/write excel file 
- Pros
  - Simple to use API with good documentation
  - Can work with active excel file
  - Currently in active development, with good community support
- Cons
  - Require Excel installation on your system
- What do i think about it?
  - This is my favorite library to read/modify/write excel file
  - only reason to not use it if you don't have excel or want to build webapp

#### [openpyxl](https://openpyxl.readthedocs.io/)
- What is it?
- Pros
  - No dependency on Excel, so you can use it on any computer
  - Currently in active development
- Cons
  - Lack functionality compared to xlWings
- What do i think about it?
  - I prefer xlWings over openpyxl due to it's simple api and functionality
  - I only use this library with streamlit webapps since it's os independent and don't require any excel installation

## AutoCad Libraries

#### [ezDxf](https://ezdxf.readthedocs.io/)
- What is it?
  - library to read/write/modify dxf file
- Pros
  - Simple to use API with good documentation
  - No dependency on AutoCAD, so you can use it on any computer
  - Currently in active development, so will get more features and fixes with time
- Cons
  - Can't work with autocad drawings, we have to convert it to dxf first
- What do i think about it?
  - It's my current favorite library to generate drawings via python
  - It covers 90% stuff most projects requries

#### [pyautocad](https://pyautocad.readthedocs.io/)
- What is it?
  - library to manipulate autocad drawings
- Pros
  - it can directly work with Active autocad drawings
- Cons
  - not in active development, last commit was in 2016
  - Bad Documentation so not suitable for beginners
- What do i think about it?
  - I prefer ezDxf over pyautocad
  - if really need to automate drawings then ezDxf is best option
  - If you really want to interact with AutoCAD then go with VBA or C#

## Data Visualization Libraries

#### MathplotLib
- What is it?
- Pros
- Cons
- What do i think about it?

#### Plotly 
- What is it?
- Pros
- Cons
- What do i think about it?

#### seaborn
- What is it?
- Pros
- Cons
- What do i think about it?

## GUI Libraries

## Libraries for Civil Engineering

#### HandCalc
- What is it?
- Pros
- Cons
- What do i think about it?

#### forallpeople
- What is it?
- Pros
- Cons
- What do i think about it?

## Miscellaneous

#### comtypes
- What is it?
  - it's python package which will allow you to use VBA API calls using python
- Pros
  - Provide workaround for python development for Older software which don't have any official python API
  - Opensouce with good documentation
- Cons
  - It's really hard to debug if you bump into any unknown error
  - No access to intellisence of class and modules make it very easy to make mistakes in code
- What do i think about it?
  - It's good enough for personal project which don't require complex functionality
  - I always perfer to use official API for my clients for more stability and long term support