#!/usr/bin/python
import MySQLdb
from time import sleep
import random

db = MySQLdb.connect(host="localhost",    # your host, usually localhost
                     user="demo",         # your username
                     passwd="demopassword",  # your password
                     db="demo")        # name of the data base

# you must create a Cursor object. It will let
#  you execute all the queries you need
cur = db.cursor()

for x in range(0, random.randint(10,100)):
    # Use all the SQL you like
    cur.execute("SELECT * FROM demo ORDER BY RAND()")
    # print all the first cell of all the rows
    for row in cur.fetchall():
        sleep(0.01)

db.close()
