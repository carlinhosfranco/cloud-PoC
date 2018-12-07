#!/bin/bash

ENVIRONMENT=native

get_memory(){
	CONFIG="mem"
	GREP_MEMORY=$1
	MAX=$2
	#Loop para as Threads
	for (( th = 1; th <= $MAX; th++)); do
		#grep "$GREP_MEMORY" "$CONFIG"_"$th".log | awk 'BEGIN {FS" "}; {sum+=$3;var+=$3^2}; {c++}; END {printf '$th'; printf "\t"; printf sum/c; printf "\t"; printf sqrt(var/c-(sum/c)^2); printf "\t"; printf '$th'; printf "\n";}' >> "$CONFIG"_memory.dat
		grep "$GREP_MEMORY" "$CONFIG"_"$th".log | awk 'BEGIN {FS" "}; {sum+=$2;var+=$2^2}; {c++}; END {printf '$th'; printf "\t"; printf sum/c; printf "\t"; printf sqrt(var/c-(sum/c)^2); printf "\t"; printf '$th'; printf "\n";}' >> "$CONFIG"_"$GREP_MEMORY".dat
		#grep "$GREP_MEMORY" "$CONFIG"_"$th".log | awk -F" " {'print $1" "$2" " $3'}
	done
	echo \#$GREP_MEMORY"_"$ENVIRONMENT >> "$CONFIG"_"$GREP_MEMORY".dat
}

get_proc(){

	CONFIG="proc"
	GREP_PROC="       1"
	th=1
	#Loop para as Threads
	#for (( th = 2; th < 9; th=`expr $th + 2` )); do
		
	grep "$GREP_PROC" "$CONFIG"_"$th".log | awk 'BEGIN {FS" "}; {sum+=$6;var+=$6^2}; {c++}; END {printf '$th'; printf "\t"; printf sum/c; printf "\t"; printf sqrt(var/c-(sum/c)^2); printf "\t"; printf '$th'; printf "\n";}' >> "$CONFIG".dat
	#grep "$GREP_PROC" "$CONFIG"_"$th".log | awk -F" " {'print $6 '}
		
	echo \#LINPACK_$ENVIRONMENT >> "$CONFIG".dat

}

get_net(){
	CONFIG="net"
	#IP PARA COLETAR, COM A SEQUÊNCIA DE ESPAÇOS
	GREP_NET="192.168.122.21     "
	MAX=$1
	#Loop para as Threads

	for (( th = 1; th <= $MAX; th++)); do
		#grep "$GREP_MEMORY" "$CONFIG"_"$th".log | awk 'BEGIN {FS" "}; {sum+=$3;var+=$3^2}; {c++}; END {printf '$th'; printf "\t"; printf sum/c; printf "\t"; printf sqrt(var/c-(sum/c)^2); printf "\t"; printf '$th'; printf "\n";}' >> "$CONFIG"_memory.dat
		grep "$GREP_NET" "$CONFIG"_"$th".log | awk 'BEGIN {FS" "}; {sum+=$4;var+=$4^2}; {c++}; END {printf '$th'; printf "\t"; printf sum/c; printf "\t"; printf sqrt(var/c-(sum/c)^2); printf "\t"; printf '$th'; printf "\n";}' >> "$CONFIG"_uperf.dat
		#grep "$GREP_NET" "$CONFIG"_"$th".log | awk -F" " {'print $4'}
	done
	echo \#UPERF_$ENVIRONMENT >> "$CONFIG"_uperf.dat
}

get_io(){

	CONFIG="io"
	#GREP_PROC=$1
	array=( "Writer report" "Re-writer report" "Reader report" "Re-Reader report" "Fwrite report" "Re-Fwrite report" "Fread report" "Re-Fread report" )
	#array=( "Random read report" )
	#array_dat=( "Random_read"  )	
	#array_dat=( "Random_read" "Random_write" "Backward_read" "Record_rewrite" "Stride_read" "Fwrite" "Re-Fwrite" "Fread" "Re-Fread" )
	array_dat=( "Writer" "Re-writer" "Reader" "Re-Reader" "Random_read" "Random_write" "Backward_read" "Record_rewrite" "Stride_read" "Fwrite" "Re-Fwrite" "Fread" "Re-Fread" )
	#array_dat=( "Writer" "Re-writer" )
	
	th=1
	MAX_IDX=$(echo ${#array[@]})
	#echo $MAX_IDX
	#Loop para as Threads
	for((AUX=0; AUX < $MAX_IDX; AUX++)) do
		#echo ${array[$AUX]}
		grep "${array[$AUX]}" "$CONFIG"_"$th".log | awk -F" " {'print $4'}
		#echo "$CONFIG"_${array_dat[$AUX]}.dat
		#grep "${array[$AUX]}" "$CONFIG"_"$th".log | awk 'BEGIN {FS" "}; {sum+=$5;var+=$5^2}; {c++}; END {printf '$th'; printf "\t"; printf sum/c; printf "\t"; printf sqrt(var/c-(sum/c)^2); printf "\t"; printf '$th'; printf "\n";}' #>> "$CONFIG"_${array_dat[$AUX]}.dat
		#echo $AUX
		#echo \#"$CONFIG"_${array_dat[$AUX]}_$ENVIRONMENT #>> "$CONFIG"_${array_dat[$AUX]}.dat
		echo " "
	done
}



get_io2(){

	CONFIG="io"
	#GREP_PROC=$1
	#array=( "Writer report" "Re-writer report" "Reader report" "Re-Reader report" "Random read report" "Random write report" "Backward read report" "Record rewrite report" "Stride read report" "Fwrite report" "Re-Fwrite report" "Fread report" "Re-Fread report" )
	
	array=( "Random read report" "Random write report" "Backward read report" "Record rewrite report" "Stride read report" )
	array_dat=( "Random_read" "Random_write" "Backward_read" "Record_rewrite" "Stride_read" )	
	#array_dat=( "Writer" "Re-writer" "Reader" "Re-Reader" "Random_read" "Random_write" "Backward_read" "Record_rewrite" "Stride_read" "Fwrite" "Re-Fwrite" "Fread" "Re-Fread" )
	#array_dat=( "Writer" "Re-writer" )
	
	th=1
	MAX_IDX=$(echo ${#array[@]})
	#echo $MAX_IDX
	#Loop para as Threads
	for((AUX=0; AUX < $MAX_IDX; AUX++)) do
		#echo ${array[$AUX]}
		#grep "${array[$AUX]}" "$CONFIG"_"$th".log | awk -F" " {'print $5'}
		#echo "$CONFIG"_${array_dat[$AUX]}.dat
		grep "${array[$AUX]}" "$CONFIG"_"$th".log | awk 'BEGIN {FS" "}; {sum+=$5;var+=$5^2}; {c++}; END {printf '$th'; printf "\t"; printf sum/c; printf "\t"; printf sqrt(var/c-(sum/c)^2); printf "\t"; printf '$th'; printf "\n";}' >> "$CONFIG"_${array_dat[$AUX]}.dat
		#echo $AUX
		echo \#"$CONFIG"_${array_dat[$AUX]}_$ENVIRONMENT >> "$CONFIG"_${array_dat[$AUX]}.dat
		echo " "
	done
}

get_io_full(){

	CONFIG="io"
	#array=( "Writer" "Re-writer" "Reader" "Re-Reader" "Random_read" "Random_write" "Backward_read" "Record_rewrite" "Stride_read" "Fwrite" "Re-Fwrite" "Fread" "Re-Fread" )
	array=( "Writer" "Re-writer" "Reader" "Re-Reader" "Random_read" "Random_write" )
	th=1
	MAX_IDX=$(echo ${#array[@]})
	#echo $MAX_IDX
	FIL=3
	
	for((AUX=0; AUX < $MAX_IDX; AUX++)) do
		#echo Fil: $FIL
		#grep "            5120" "$CONFIG"_"$th".log | awk -F" " {'print $'$FIL''}
		#grep "            5120" "$CONFIG"_"$th".log | awk 'BEGIN {FS" "}; {printf $'$FIL' "\n" }; {sum+=$'$FIL';var+=$'$FIL'^2}; {c++}; END {printf '$th'; printf "\t"; printf sum/c; printf "\t"; printf sqrt(var/c-(sum/c)^2); printf "\t"; printf '$th'; printf "\n";}' #>> "$CONFIG"_${array[$AUX]}.dat
		grep "        10485760" "$CONFIG"_"$th".log | awk 'BEGIN {FS" "}; {sum+=$'$FIL';var+=$'$FIL'^2}; {c++}; END {printf '$AUX'; printf "\t"; printf sum/c; printf "\t"; printf sqrt(var/c-(sum/c)^2); printf "\t"; printf '$AUX'; printf "\n";}' >> "$CONFIG"_full.dat
		FIL=`expr $FIL + 1`
	done
	echo \#"$CONFIG"_$ENVIRONMENT >> "$CONFIG"_full.dat
}



#Comment: PASSE O NÚMERO MÁXIMO DE THREADS
#get_net 8
get_proc

#Comment: get_memory "NOME DA OPERAÇÃO" "NÚMERO DE MÁXIMO DE THREADS"
get_memory Copy 8
get_memory Scale 8
get_memory Add 8
get_memory Triad 8

get_io_full

echo "Done! :)"
echo " "

mkdir $(pwd)/$ENVIRONMENT
mv *.dat $(pwd)/$ENVIRONMENT/
echo "Verificando os arquivos dats"
ls -l $(pwd)/$ENVIRONMENT

mkdir $(pwd)/$ENVIRONMENT/all_logs
mv *.log $(pwd)/$ENVIRONMENT/all_logs/
mv *.out $(pwd)/$ENVIRONMENT/all_logs/
echo " "
echo "Logs salvos em: " $(pwd)/$ENVIRONMENT/all_logs/
ls -l $(pwd)/$ENVIRONMENT/all_logs/
