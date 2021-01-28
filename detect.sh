#!/bin/bash
MONITORDIR="./"
inotifywait -m -r -e create --format '%w%f' "${MONITORDIR}" | while read FILENAME
do 
	echo "${FILENAME}"	
	if [[ ${FILENAME} == "./"* &&  ${FILENAME} != "./"*"."* ]]; then
		
		mv ${FILENAME} bin/
		chmod 755 bin/${FILENAME}
		echo "${FILENAME} if state"
	fi
done

