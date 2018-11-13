function to() {
    mapfile="$HOME/.maps/directories.map"
    
    if [ ! -f $mapfile ]; then
	echo "directory map file doesn't exist"
        return
    fi 
    
    if [ -z "$1" ]; then
        echo "Please choose from the following 'to' destinations:"
        echo ""
        sort $mapfile | tr ':' ' ' | while read s d
        do
            printf "%-15s %s\n" $s $d
        done
        return
    fi

    if [ "$1" = "-e" ]; then
        vi $mapfile
        return
    fi
    # Check to see if this is a map file entry
    if [ ! "$1" = "-p" ]; then
        key=$1
        mapfile_ent="`grep ^${key}: $mapfile | awk -F: '{ print $2 }'`"
        if [ ! -z "$mapfile_ent" ]; then
            echo $mapfile_ent
            cd $mapfile_ent
            return
        fi
    else
        shift
    fi

    # It's nothing
    echo 'Nothing matches that key. Sorry :('
}

