#!/bin/sh

SOURCE="${BASH_SOURCE[0]}"
DIR="$( dirname "$SOURCE" )"
while [ -h "$SOURCE" ]
do 
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
  DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd )"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

replace_force=0

for p in "$@"
do
    if [ "$p" == "-force" ]
    then
        replace_force=1
    fi
done

if [ "$replace_force" -eq "1" ]
then
    echo "Forcing all replacements"
fi

cat $DIR/.mapconf | while read line;
do
    x1=`echo $line | sed 's/.*=>\s*~\(.*\)/\1/'`
    x2=`echo $line | sed 's/\(.*\)=>.*/\1/'`
    x1=$HOME$x1
    if [ -e $x1 ]
    then
        if [ "$replace_force" -eq "1" ]
        then
            rm -rf $x1
        fi
    fi
    if [ -e $x1 ]
    then
        echo WARNING: $x1 exists. NOT replaced.
    else
        echo linking $x1
        ln -s $DIR/$x2 $x1
    fi
done
