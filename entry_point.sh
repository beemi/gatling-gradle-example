#!/bin/sh -e

echo "Starting load test........"

./gradlew clean build && gradle gatlingLogback && gradle gatlingRun &&

echo "Finished load test......."