#!/bin/bash

dir=./*
for file in $dir
do
        echo "$file"
        if [[ "$file" == *".zip" ]]; then
                echo "${file:2}"
                #                                               res에 drawable들을 압축푼다.
                unzip "${file:2}" -d /mnt/e/oil/oilbank/app/src/main/res
                rm "${file:2}"
        fi
done
