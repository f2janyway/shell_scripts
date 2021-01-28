#!/bin/bash
#1. ./ 는 현재 디렉토리
MONITORDIR="./"
#현재 디렉토리에서 생성 되는 파일,폴더를 관찰하고		         파일을 읽는다.
inotifywait -m -r -e create --format '%w%f' "${MONITORDIR}" | while read FILENAME
do 
	echo "${FILENAME}"	
	#           생기는 파일중에            확장자가 없으면
	if [[ ${FILENAME} == "./"* &&  ${FILENAME} != "./"*"."* ]]; then
		# 해당 디렉토리에 있는 bin 디렉토리로 옮기고
		mv ${FILENAME} bin/
		# 권한 설정해준다. mv 할 때 권한이 바뀌는 듯...
		chmod 755 bin/${FILENAME}
		echo "${FILENAME} if state"
	fi
done

