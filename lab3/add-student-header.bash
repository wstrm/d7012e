#!/bin/bash

for i in *.hs
do
	cat student-header.txt $i >$i.new && mv $i.new $i
done
