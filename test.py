#!/usr/bin/python

# DOCKER_HOST=tcp://127.0.0.1:2375 docker run ubuntu echo hello
import subprocess
import os
os.environ["DOCKER_HOST"] = "tcp://127.0.0.1:2375"
cmd = "docker run ubuntu echo hello"
cmdSplit = cmd.split(" ")
print 'try 1'
print subprocess.check_output(cmdSplit)
print 'try 2'
print subprocess.check_output(cmd, shell=True)
