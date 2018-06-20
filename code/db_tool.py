# !/usr/bin/python

import mysql.connector
import matplotlib.pyplot as plt
from itertools import groupby
import time

def open_conn():
    """open the connection before each test case"""
    conn = mysql.connector.connect(user='root', password='root',
                                   host='127.0.0.1',
                                   database='yelp_db'
                                   )

    return conn

def close_conn(conn):
    """close the connection after each test case"""
    conn.close()
    
def executeQuery(conn, query, commit=False):
    """ fetch result after query"""
    cursor = conn.cursor(buffered=True)
    query_num = query.count(";")
    if query_num > 1:
        for result in cursor.execute(query, params=None, multi=True):
            if result.with_rows:
                result = result.fetchall()
    else:
        cursor.execute(query)
        result = cursor.fetchall()
    # we commit the results only if we want the updates to the database
    # to persist.
    if commit:
        conn.commit()
    else:
        conn.rollback()
    # close the cursor used to execute the query
    cursor.close()
    return result

if __name__ == '__main__':
    pass
