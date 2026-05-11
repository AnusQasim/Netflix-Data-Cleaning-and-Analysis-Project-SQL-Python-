# Netflix Data Cleaning and Analysis using SQL & Python

## Project Overview

This project demonstrates an end-to-end data analytics workflow using Python and SQL Server on the Netflix Titles dataset.

The project includes:

- Importing CSV data into SQL Server
- Cleaning and transforming raw data
- Handling duplicates and null values
- Creating normalized tables
- Performing exploratory data analysis using SQL queries
- Generating business insights from Netflix content data

---

# Tech Stack

- Python
- Pandas
- SQLAlchemy
- PyODBC
- Microsoft SQL Server
- T-SQL

---

# Dataset

Dataset used: Netflix Titles Dataset

Main columns include:

- Show ID
- Title
- Director
- Cast
- Country
- Release Year
- Rating
- Duration
- Genre
- Description

---

# Project Workflow

## 1. Data Import

- Loaded CSV dataset using Pandas
- Connected Python with SQL Server using SQLAlchemy
- Inserted raw data into SQL Server

## 2. Data Cleaning

Performed several cleaning operations:

- Removed duplicate records
- Converted date formats
- Handled missing values
- Standardized duration column
- Split multi-value columns into normalized tables

## 3. Data Modeling

Created separate tables for:

- Genres
- Directors
- Countries

This improved query performance and data normalization.

---

# Analysis Performed

Some key business questions answered:

- Which directors created both Movies and TV Shows?
- Which country produced the highest number of Comedy movies?
- Who was the top movie director each year?
- What is the average movie duration by genre?
- Which directors worked in both Comedy and Horror genres?

---

# Key Insights

- Comedy is among the most common movie genres on Netflix
- Several directors contribute to both Movies and TV Shows
- Movie durations vary significantly across genres
- Certain countries dominate specific genres

---

# Project Structure

```text
Netflix-Data-Cleaning-and-Analysis/
│
├── data/
│   └── netflix_titles.csv
│
├── sql/
│   └── netflix_project.sql
│
├── python/
│   └── data_import.py
│
├── README.md
```

---

# How to Run the Project

## Clone Repository

```bash
git clone <your-repository-link>
```

## Install Required Libraries

```bash
pip install pandas sqlalchemy pyodbc
```

## Run Python Script

```bash
python data_import.py
```

## Execute SQL Queries

Run the SQL script inside SQL Server Management Studio (SSMS).

---

# Future Improvements

- Build Power BI Dashboard
- Add Python visualizations
- Create automated ETL pipeline
- Deploy using Azure SQL Database

