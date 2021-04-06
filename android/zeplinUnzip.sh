#!/bin/bash

#dir=~/Downloads/chrome_download/*
dir=~/Downloads/chrome_download/*
drawable=~/android/4mation_android/app/src/main/res
for file in $dir
do
        echo "$file"
        if [[ "$file" == *".zip" ]]; then
                echo "${file}"
                #                                               res에 drawable들
을 압축푼다.
                unzip "${file}" -d $drawable
               f rm "${file}"
        fi
done
