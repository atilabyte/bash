



true=1000



while true ; do




vkzmn_ok=0


sleep  1



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




echo $vkzmn_ok #vkzmn   in execution





else 





echo  vkzmn_not_ok



chmod 777  /tmp/vkzmn



nohup   /tmp/./vkzmn   & 








fi ; 





done

