#!/bin/bash

: ${fps:=1}
: ${seconds:=60}
: ${fontSize:=180}
: ${fontColor:=black}
: ${fontFile:=/home/raphink/.local/share/fonts/FrancoisOne.ttf}
: ${imageFile:=./meetup_2020-05_1080p.png}
#: ${positionX:="(w-text_w)/2"}
: ${positionX:="0.1*w"}
#: ${positionY:="(h-text_h)/2"}
: ${positionY:="0.9*h-text_h"}
: ${soundFile:=./Robot_Coupe_No_Vocal_-_Lost_European.mp3}
: ${outFile:="meetup_wait_2020-05_1080p.mp4"}

ffmpeg -loop 1 \
	-i $imageFile \
	-stream_loop -1 -i $soundFile \
	-c:v libx264 -r $fps -t $seconds -pix_fmt yuv420p \
	-vf "fps=$fps,drawtext=fontfile='$fontFile':fontcolor=$fontColor:fontsize=$fontSize:x=$positionX:y=$positionY:text='%{eif\:($seconds-mod($seconds-t,60))/60\:d\:2}\:%{eif\:mod($seconds-t,60)\:d\:2}'" \
	"$outFile"
