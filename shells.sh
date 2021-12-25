#!/bin/bash

component=$1$( echo "$component" | tr '[:lower:]' '[:upper:]' )
view_class=$2$( echo "$view_class" | tr '[:lower:]' '[:upper:]' )
scale=$3$( echo "$scale" | tr '[:lower:]' '[:upper:]' )
count=$4
anyfile=$5

Bidfunction () { 
	LINE_NUM=$( cat $anyfile | grep -i -n "$component" | grep -i -n "$VAR" | awk -F ":" '{print $2}' ) # FILE
    	if [[ $LINE_NUM -ne "NULL" ]]
        then

                FILE=$( cat $anyfile | grep -i  "$component" | grep -i  "$VAR"  )
                NEW_SCALE=$( echo $FILE | awk -F ';' '{print $2}')
                NEW_COUNT=$( echo $FILE | awk -F '=' '{print $2}')
                NEW_FILE=$( echo $FILE | sed  "s/$NEW_SCALE/$scale/g"  )
                NEW_FILE2=$( echo $NEW_FILE | sed  "s/$NEW_COUNT/$count/g"  )
                sed -i "s/$FILE/$NEW_FILE2/g" $anyfile
        else
                echo "Invalid Input!!!Please try again."
        fi
}


Auctionfunction () {
	
	LINE_NUM=$( cat $anyfile | grep -i -n  "$component" | grep -i -n -v "$VAR" | awk -F ":" '{print $2}' ) 
    	FILE=$( cat $anyfile | grep -i  "$component" | grep -i -v "$VAR"  )
    	NEW_SCALE=$( echo $FILE | awk -F ';' '{print $2}')                            
    	NEW_COUNT=$( echo $FILE | awk -F '=' '{print $2}')         
    	NEW_FILE=$( echo $FILE | sed  "s/$NEW_SCALE/$scale/g"  )

    	NEW_FILE2=$( echo $NEW_FILE | sed  "s/$NEW_COUNT/$count/g"  )
    	sed -i "s/$FILE/$NEW_FILE2/g" $anyfile

}


VAR="BID"
if [[ "$view_class" =~ "AUCTION" ]]
then
        Auctionfunction

elif [[ "$view_class" =~ "BID" ]]
then
        Bidfunction

else    
        echo "Error!!! Invalid Input." 
fi
cat $anyfile
