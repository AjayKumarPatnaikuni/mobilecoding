#! /bin/bash

# pre-requisites are termux installed with API package. 

# TTS needs to be enabled.

while :
	do
		echo "========================Checking Battery health status=========================="
		a=`termux-battery-status | grep percentage | awk '{print $2}' | cut -d, -f1`
       		k=`termux-battery-status | grep status | awk '{print $2}' | cut -d'"' -f2`
        	b=`echo $a-1|bc -l`
		
		function charging {  termux-tts-speak "your battery fully charged  and it is $a percentage now" && termux-vibrate -d 2000 -f ; }
		function dis_charging { termux-tts-speak "your battery is going to die and it is bloody $a percentage now" && termux-vibrate -d 2000 -f ; }
		
		if [ "$k" == "FULL" ] ; then
		
               		charging ; sleep 1 ;
        	
		elif [ "$k" == "CHARGING" ] && [ $b -gt 98 ] ; then
		
			charging ; sleep 2 ;
		
		elif [ "$k" == "CHARGING" ] && [ $b -lt 98 ] ; then
		
			sleep 5 ; echo "	Keep $k -- $b % It needs to charge............................"
		
		elif [ "$k" == "DISCHARGING" ] && [ $b -lt 35 ] ; then
		
			dis_charging ; sleep 2 ;
		
		elif [ "$k" == "DISCHARGING" ] && [ $b -gt 35 ] ; then
		
			sleep 5 ; echo "	$k -- $b % It is normal condition........................"
		
		fi
		
	done
  
