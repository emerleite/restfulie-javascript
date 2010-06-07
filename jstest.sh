#!/bin/bash
cd client/restfulie

cd spec
ruby server.rb &
SINATRA=$!
cd ..

jspec run --browsers ff &
JSPEC_PID=$!
while [ ! -f finished ]; do
	sleep 1
done
kill $JSPEC_PID
kill $SINATRA
FAILS=`cat finished`
rm finished
echo $FAILS
exit $FAILS