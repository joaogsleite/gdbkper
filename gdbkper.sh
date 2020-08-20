#!/usr/bin/env bash

# =================================
# USAGE:
# =================================
# 
# Init google drive token
# ./gdbkper init
#
# Backup project to google drive
# ./gdbkper backup
#
# Restore project from google drive
# ./gdbkper restore <date>
#
# =================================

docker run -it --rm -v $PWD:/backup n1zes/gdbkper $@