#!/bin/bash

docker run -d --name jupyter -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes jupyter/datascience-notebook:latest

