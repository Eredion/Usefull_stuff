#! /usr/bin/env sh

echo "\033[0;33mReminder: Use option -i to restart workspace"
docker rm -f workspace > /dev/null
if  [[ $1 = "-i" ]]; then
docker rmi -f ubuntu_workspace > /dev/null
echo "\033[0;34mThe workspace will be folder: \033[0;91m${PWD}\033[0;39m"
echo "\033[0;96mCreating and building docker image (It will take a few seconds)"
echo "..."
mkdir tmp_folder > /dev/null
echo "FROM ubuntu

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y sudo vim ruby
RUN gem install bundler" > tmp_folder/Dockerfile


docker build -t "ubuntu_workspace" tmp_folder/ > /dev/null
rm -rf tmp_folder > /dev/null
fi
echo "\033[0;96mRunning!\033[0;39m"
docker run --name=workspace -it -v ${PWD}:/workspace ubuntu_workspace
