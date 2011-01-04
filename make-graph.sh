#!/bin/sh
RRD=powertemp.rrd
rrdtool graph power-$1.png \
  --start end-$1 \
  --end now \
  --width 700 \
  --height 400 \
  --slope-mode \
  --no-legend \
  --vertical-label Watts \
  --lower-limit 0 \
  --alt-autoscale-max \
  DEF:PowerMin=$RRD:Normal:MIN \
  DEF:PowerMax=$RRD:Normal:MAX \
  DEF:Power=$RRD:Normal:AVERAGE \
  CDEF:PowerRange=PowerMax,PowerMin,- \
  LINE1:PowerMin: \
  AREA:PowerRange#0000FF11:"Error Range":STACK \
  LINE1:PowerMin#0000FF33:"Min" \
  LINE1:PowerMax#0000FF33:"Max" \
  LINE1:Power#0000FF:"Average"
