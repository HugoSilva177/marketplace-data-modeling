# Use official Python image
FROM python:3.11-slim

# Create directories
RUN mkdir -p /app/duckdb

# Install dependencies
RUN pip install --upgrade pip && \
    pip install duckdb && \
    pip install dbt-duckdb

# Copy files
COPY ./dbt_project /app/dbt_project
COPY ./src /app

WORKDIR /app/dbt_project

RUN dbt deps --project-dir /app/dbt_project