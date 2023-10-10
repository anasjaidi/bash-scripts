#!/bin/bash

a=12
b=30

sum=$(expr $a - 25)

# expr keyword to tell interpreter to evaluate it as math expr $(for run it as a command)
echo $(expr $a + $b )
echo $(expr $a - $b )
echo $(expr $a / $b )
echo $(expr $a \* $b )
echo $(expr $a % $b )

echo $sum

echo $(expr 30 / 0)