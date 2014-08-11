#!/bin/bash

on_die ()
{
    pkill -KILL -P $$
}

trap 'on_die' TERM
echo $(date +[%FT%TZ]) screenshot screenshot_$1.jpg >> /var/log/nginx/screenshot.log
ffmpeg -i rtmp://localhost/transcode/$1 -updatefirst 1 -f image2 -vcodec mjpeg -vframes 1 -y /var/www/html/img/channel_$1.jpg 2> /var/log/ffmpeg/screenshot-$1.log
sleep 15s