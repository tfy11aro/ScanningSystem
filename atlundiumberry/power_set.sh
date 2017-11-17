#!/bin/bash

echo "Args: $1 $2 $3"
if [ "$1" == "setup" ]; then
	cp /dev/null power.log
	sudo chmod o+rw /dev/ttyUSB0
	stty -F /dev/ttyUSB0 9600 cs8 -cstopb -parenb -echo
	echo -e "ADR 06\n" >> power.log
	echo -e "OUT 0\n" >> power.log
	#cat < /dev/ttyUSB0 | tee power.log &
	echo -ne 'ADR 06\015' > /dev/ttyUSB0
	echo -ne 'OUT 0\015' > /dev/ttyUSB0
	echo -ne 'PV 8.5\015' > /dev/ttyUSB0
fi

if [ "$1" == "cmd" ]; then
	echo "Running cmd: $2 $3\015"
	echo -ne "$2 $3\n" >> power.log
	echo -ne "$2 $3\015" > /dev/ttyUSB0
fi

if [ "$1" == "meas" ]; then
	echo "Running measure: $2\015"
	echo -ne "$2\n" >> power.log
	echo -ne "$2\015" > /dev/ttyUSB0
fi
