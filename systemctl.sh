#!/bin/bash

if [[ "$1" == "show" ]];
then
  /usr/bin/.systemctl.orig $@
else
  /usr/bin/supervisorctl $@
fi
