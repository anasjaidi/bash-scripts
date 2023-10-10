#!/bin/bash

# declare variable
sentence="anas jaidi"

# use variable
echo "my name is $sentence"

# bind out of command to var
files=$(ls -la)

# use variable
echo "$files"

# use env vars
echo "hello mr $USER"