!/bin/bash

#Script for given inputs 


COMPONENT=( INGESTOR JOINER WRANGLER VALIDATOR )
SCALE=( MID HIGH LOW )
VIEW=( AUCTION BID )
COUNT=( 1 2 3 4 5 6 7 8 9 )

read -p "Enter Component: " Component
if [[ " ${COMPONENT[*]} " =~ " ${Component} " ]]; then
    echo " Valid component: $COMPname selected "
fi

if [[ ! " ${COMPONENT[*]} " =~ " ${Component} " ]]; then
    echo " invalid component: try again"

   read -p "Try again: " Component

fi

read -p "Enter View option: " View
 if [[ " ${VIEW[*]} " =~ " ${View} " ]]; then
    echo " Valid component: $View selected "
fi

if [[ ! " ${VIEW[*]} " =~ " ${View} " ]]; then
    echo " invalid component: try again"
     read -p "Try again: " View

fi

echo "Enter the scale measure:"
select Scale  in "${SCALE[@]}"; do
if [[ "${SCALE[*]}" == *"$Scale"* ]]; then
echo "$Scale"
break
else
echo "invalid scale measure"  
fi
done

echo "Enter the count number:"
select Count  in "${COUNT[@]}"; do
if [[ "${COUNT[*]}" == *"$Count"* ]]; then
echo "$Count"
break
else
echo "invalid count number"  
fi
done


#change the file line

if [ "$View" == "AUCTION" ]; then
if cat sig.conf | grep -n -v "vdopiasample-bid" | grep -n -q "$Component" ; then
line_num=$( cat sig.conf | grep -n -v  "vdopiasample-bid" | grep  "$Component" | awk  -F ':' '{print $1}')
initial_scale=$( cat sig.conf | grep -n -v  "vdopiasample-bid" | grep  "$Component" | awk  -F ';' '{print $2}')
initial_count=$( cat sig.conf | grep -n -v  "vdopiasample-bid" | grep  "$Component" | awk  -F '=' '{print $2}')


sed -i "${line_num}s/${initial_scale}/${Scale}/" sig.conf
sed -i "${line_num}s/${initial_count}/${Count}/" sig.conf

echo "the file is changed succussfully"
else
echo "the selected inputs are invalid"
fi

else
if cat sig.conf | grep -n  "vdopiasample-bid" | grep -n -q "$Component " ; then

line_num=$( cat sig.conf | grep -n   "vdopiasample-bid" | grep  "$Component" | awk  -F ':' '{print $1}')
initial_scale=$( cat sig.conf | grep -n   "vdopiasample-bid" | grep  "$Component" | awk  -F ';' '{print $2}')
initial_count=$( cat sig.confi | grep -n   "vdopiasample-bid" | grep   "$Component" | awk  -F '=' '{print $2}')

sed -i "${line_num}s/${initial_scale}/${Scale}/" sig.conf
sed -i "${line_num}s/${initial_count}/${Count}/" sig.conf
echo "the file is changed succussfully"
else
echo "the selected inputs are invalid"
fi
fi


cat sig.conf
