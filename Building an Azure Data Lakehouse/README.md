# Divvy Bikeshare Data Lake Solution

## Project Overview

In this project, we are tasked with building a data lake solution for the Divvy bikeshare program, based in Chicago, Illinois. Divvy is a popular bike-sharing program where users can unlock bikes at various stations around the city using a pass or a mobile application. The goal of this project is to create a data lake solution in **Azure Databricks** with a **Lakehouse architecture** to analyze and visualize the data for various business outcomes.

The data provided by Divvy is anonymized and includes bike trip data, which has been augmented with fake rider and account profiles, as well as fake payment data to create a more complete dataset. The dataset consists of several tables, including:

- **Rider**: Information about the riders.
- **Payment**: Payment data for each ride.
- **Trip**: Information on each bike trip taken.
- **Station**: Information about the bike stations.


---

## Solution Architecture

This project leverages **Azure Databricks** with **Delta Lake** to implement a **Lakehouse Architecture**. The solution involves the following steps:

### 1. **Designing a Star Schema**

A star schema is designed to structure the data efficiently for querying and analysis. This will include fact and dimension tables based on the Divvy dataset.

![Bike Share Star Schema](bike_share_star_schema.png)

### 2. **Extract Step**

- In this step, we will extract raw data from the source files (CSV) and load it into the Databricks environment.
-  The raw data will be written into Delta format, a distributed data storage format used by Delta Lake for handling large-scale data processing.

By storing the data in Delta format, we enable efficient querying and ensure that the data is optimized for later transformations.

### 3. **Load Step**

- In the Load step, we will create Delta tables from the raw data and load it into the Databricks environment. 
- These tables will be used for further transformations, such as generating fact and dimension tables.

Creating and loading the data into tables will allow us to use SQL queries and further transformations on these structured tables.

### 4. **Transform Step**

- In the Transform step, we will perform the core data transformations to generate fact and dimension tables based on the schema we designed earlier. 
- This is where we will join raw data with dimension tables and create fact tables that contain relevant business metrics.

The goal of this step is to generate clean, structured, and normalized data that supports efficient querying of business metrics. For example, analyzing how long riders take on trips based on time of day, or how much money riders spend over time.

---

## Technologies Used

- **Azure Databricks**: Platform for building the data lake and lakehouse architecture.
- **Delta Lake**: For managing large-scale data lakes with ACID transactions.
- **SQL**: For querying and transforming the data.
- **Python**: For additional data transformations and automation.


