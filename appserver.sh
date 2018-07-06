#!/bin/bash

yes start | xargs -P 14 -n 1 /usr/bin/python /usr/local/bin/appserver.py
