DIR=${PWD##*/}


DEST="FILE_NAME_FOLDER"

echo "Enter the recpient email address"
read EMAIL

if [[ "$EMAIL" =~ ^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$ ]]
then
    echo "Enter short description"
    read DESC

    echo $DESC >> body.txt

    mkdir $(pwd)/$DEST

    FILENAME=$DIR-$(date +%Y-%m-%d_%H_%M_%S).tar.gz
    tar -czf $FILENAME $(pwd)/$DEST
    mutt -s "Backup" -a $FILENAME -- $EMAIL < body.txt

    # Cleanup
    rm -rf $FILENAME
    rm -rf $DEST
    rm body.txt
    echo "Archive sent"
else
    echo "Email address $EMAIL is invalid."
fi
