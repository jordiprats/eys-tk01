#!/usr/bin/python
from BaseHTTPServer import BaseHTTPRequestHandler,HTTPServer
import MySQLdb

PORT_NUMBER = 8080

#This class will handles any incoming request from
#the browser
class myHandler(BaseHTTPRequestHandler):

    #Handler for the GET requests
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type','text/html')
        self.end_headers()

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
                self.wfile.write(row)

        db.close()

        # Send the html message
        self.wfile.write("Hello World !")
        return

try:
    #Create a web server and define the handler to manage the
    #incoming request
    server = HTTPServer(('', PORT_NUMBER), myHandler)
    print 'Started httpserver on port ' , PORT_NUMBER

    #Wait forever for incoming htto requests
    server.serve_forever()

except KeyboardInterrupt:
    print '^C received, shutting down the web server'
    server.socket.close()
