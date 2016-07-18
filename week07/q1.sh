#!/bin/bash

SOURCE=$(pwd)
DESTINATION='/home/ldorse13/proj/week07/test'

for filename in $SOURCE/* ; do
	cp $filename $DESTINATION
done 
