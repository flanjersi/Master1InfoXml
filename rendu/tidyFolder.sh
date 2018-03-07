#!/bin/bash


for filename in www/*.html; do
	tidy -qe $filename
done

exit 0
