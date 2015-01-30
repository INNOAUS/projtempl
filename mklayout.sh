#!/bin/sh

cp ../projtempl/.gitignore .
cp ../projtempl/Makefile .
cp -r ../projtempl/bin .
cp -r ../projtempl/config .
cp -r ../projtempl/devenv .
cp -r ../projtempl/doc .
cp -r ../projtempl/lib .
cp -r ../projtempl/src .
cp -r ../projtempl/xcode .
cp -r ../projtempl/package-release .
cp -r ../projtempl/projtempl.sln ./$1.sln
