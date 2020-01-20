#!/bin/bash

MYDATE="$(date +%Y-%m-%d)"
SUCCESS=0
MYDIR=/media/andy/0e2d6aab-92e0-4245-9b3e-47cc2d6113f5/bak/master0/no-clobber/dta/dta-tmp-$MYDATE

mkdir -v $MYDIR

if [ -n "$MYDATE" ] && [ -d "$MYDIR" ]; then

    mkdir -v /media/andy/0e2d6aab-92e0-4245-9b3e-47cc2d6113f5/bak/master0/no-clobber/dta/dta-tmp-$MYDATE/extracted && SUCCESS=1
        
    if ((SUCCESS)); then
	sleep 1
        scp -pr andy@10.0.0.4:/home/andy/Downloads/*.??? /media/andy/0e2d6aab-92e0-4245-9b3e-47cc2d6113f5/bak/master0/no-clobber/dta/dta-tmp-$MYDATE/
	sleep 2
        for myfile in `ls -1 /media/andy/0e2d6aab-92e0-4245-9b3e-47cc2d6113f5/bak/master0/no-clobber/dta/dta-tmp-$MYDATE/*.part1.rar`; do
            unrar x -ptorgo "$myfile" /media/andy/0e2d6aab-92e0-4245-9b3e-47cc2d6113f5/bak/master0/no-clobber/dta/dta-tmp-$MYDATE/extracted/
        done
	sleep 2
        echo " "
        echo "Starting to sha256 all files."

        for i in `ls -1 /media/andy/0e2d6aab-92e0-4245-9b3e-47cc2d6113f5/bak/master0/no-clobber/dta/dta-tmp-$MYDATE/*.???` ; do
		tmpvar=$(sha256sum "$i")
	        echo ${tmpvar##/*/} > "$i.sha256"
	done

        echo " "
        echo "Done."
    else
        echo " "
        echo "Unable to create a directory for extracting rar files. It may already exist. Aborted all subsequent commands."
    fi
else
    echo " "
    echo "Unable to create a directory for today."
fi
