import os
import sys
import duckdb
from jinja2 import Template
import subprocess

def run_reports():
    print("Starting script: select table in DuckDB...")
    with duckdb.connect("/app/duckdb/marketplace.duckdb") as duckdb_conn:
        report_query_list = [
            "1_projects_per_designer_per_month.sql",
            "2_average_time_project_completion.sql",
            "3_designer_revenue_per_period.sql",
            "4_number_revisions_per_project.sql",
        ]

        for report_query in report_query_list:
            sql_file_path = f"/app/duckdb/sql_reporting/{report_query}"
            with open(sql_file_path, "rb") as f:
                sql_query = Template(f.read().decode("utf-8")).render()

            print(f"SQL file: {report_query}")
            duckdb_conn.sql(sql_query).show()


def select_args_option(args: list):

    data_stage = args[0]
    if data_stage == 'reports':
        run_reports()

    elif data_stage.startswith("dbt"):
        dbt_commands = args
        dbt_setup_call = ["bash", "/app/dbt_run_commands.sh"] + dbt_commands

        subprocess.run(dbt_setup_call)

    else:
        raise Exception(f"Arguments '{args}' are invalid!")

if __name__ == "__main__":
    select_args_option(sys.argv[1:])