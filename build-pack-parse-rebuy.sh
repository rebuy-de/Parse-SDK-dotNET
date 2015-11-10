#!/bin/bash

if [[ `which xbuild` == "" ]]
then
	echo "xbuild isn't on your path, install it"
	exit
fi  

if [[ `which nuget` == "" ]]
then
	echo "Nuget isn't on your path, install it"
	exit
fi  

if [[ $# -ne 1 ]]
then
	echo "${0} expects one argument, the version number string"
	exit
fi

projects=("Parse/Parse.csproj" "Parse/Parse.Android.csproj" "Parse/Parse.iOS.csproj")

# build the three projects in release mode
xbuild /p:Configuration=Release /p:Platform=iPhone Parse/Parse.iOS.csproj
xbuild /p:Configuration=Release Parse/Parse.Android.csproj
xbuild /p:Configuration=Release Parse/Parse.csproj

# pack them
nuget pack -Verbosity detailed -Prop Configuration=Release -Version ${1} Parse-Rebuy.nuspec 
