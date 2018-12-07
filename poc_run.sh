#!/bin/bash
#Carlos Alberto Franco Maron
#Script para execucao dos testes no PcC.
#Criado em: 17/10/17
#Última atualização: 29/01/18


#CONT=2
#THREADS=8

UPERF=./uperf/src/uperf

LOG_IO=./logs/io
LOG_NET=./logs/net
LOG_PROC=./logs/proc
LOG_MEM=./logs/mem

FILE_IOZONE=10485760 #kB
#CRYPT_TYPE=des-ede3
ARRAY_PROC=9000
#Comment: Array size para nativo: 99900000
ARRAY_MEM=99900000
WORKLOAD_NET_TYPE=test-ssize-iperf.xml

NTP_HOST=192.168.122.11
NTP_SIZE=10485760 #10MB

UPERF_HOST=192.168.122.21

MAX_THREAD=8
MAX_INDEX=10

check_host(){
	echo Host: $(hostname)
}

io(){
	
	#Tamanho em Mega
	SIZE_FILE=$(echo $1)
	echo "-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-" >> $LOG_IO"_"$THREADS.log
	echo Start in `date +%H:%M:%S--%d/%m/%Y` 2>&1>> $LOG_IO"_"$THREADS.log
	echo Index $2 >> $LOG_IO"_"$THREADS.log
	check_host >> $LOG_IO"_"$THREADS.log
	#Record em Mega bytes
	iozone -O -s $SIZE_FILE -r \#m >> $LOG_IO"_"$THREADS.log
	echo "-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-" >> $LOG_IO"_"$THREADS.log
	echo Finish in `date +%H:%M:%S--%d/%m/%Y` 2>&1>> $LOG_IO"_"$THREADS.log
}
proc_old(){
	
	OPT=$1
	TH=$2
	echo "-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-" >> $LOG_PROC"_"$TH.log
	echo Start in `date +%H:%M:%S--%d/%m/%Y` 2>&1>> $LOG_PROC"_"$TH.log
	echo Index $3 >> $LOG_PROC"_"$TH.log
	check_host >> $LOG_PROC"_"$TH.log
	echo "" >> $LOG_PROC"_"$TH.log
	openssl speed $OPT -multi $TH &>> $LOG_PROC"_"$TH.log
	echo "" >> $LOG_PROC"_"$TH.log
	echo "-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-" >> $LOG_PROC"_"$TH.log
	echo Finish in `date +%H:%M:%S--%d/%m/%Y` 2>&1>> $LOG_PROC"_"$TH.log
}

proc(){
	
	#cc -O -o linpack linpack.c -lm
	OPT=$1
	TH=$2
	echo "-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-" >> $LOG_PROC"_"$TH.log
	echo Start in `date +%H:%M:%S--%d/%m/%Y` 2>&1>> $LOG_PROC"_"$TH.log
	echo Index $3 >> $LOG_PROC"_"$TH.log
	check_host >> $LOG_PROC"_"$TH.log
	echo "" >> $LOG_PROC"_"$TH.log
	./linpack/linpack $OPT &>> $LOG_PROC"_"$TH.log
	echo "" >> $LOG_PROC"_"$TH.log
	echo "-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-" >> $LOG_PROC"_"$TH.log
	echo Finish in `date +%H:%M:%S--%d/%m/%Y` 2>&1>> $LOG_PROC"_"$TH.log
}

stream(){

	ARRAY=$1
	export OMP_NUM_THREADS=$2
	
	echo "-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-" >> $LOG_MEM"_"$THREADS.log
	echo Start in `date +%H:%M:%S--%d/%m/%Y` 2>&1>> $LOG_MEM"_"$THREADS.log
	echo Index $3 >> $LOG_MEM"_"$THREADS.log
	check_host >> $LOG_MEM"_"$THREADS.log
	echo "" >> $LOG_MEM"_"$THREADS.log
	gcc -O -fopenmp -DSTREAM_ARRAY_SIZE=$ARRAY ./stream/stream.c -o ./stream/stream_omp
	./stream/stream_omp >> $LOG_MEM"_"$THREADS.log
	echo "" >> $LOG_MEM"_"$THREADS.log
	echo "-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-" >> $LOG_MEM"_"$THREADS.log
	echo Finish in `date +%H:%M:%S--%d/%m/%Y` 2>&1>> $LOG_MEM"_"$THREADS.log
}

network(){

	WORKLOAD=$1
	export host=$UPERF_HOST
	export s1=10M
	export s2=10M
	export nprocs=$2
	echo "-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-" >> $LOG_NET"_"$THREADS.log
	echo Start in `date +%H:%M:%S--%d/%m/%Y` 2>&1>> $LOG_NET"_"$THREADS.log
	echo Index $3 >> $LOG_NET"_"$THREADS.log
	check_host >> $LOG_NET"_"$THREADS.log
	echo "" >> $LOG_NET"_"$THREADS.log
	#cat netperf_$OLD_TH.xml | sed 's/<group nthreads='"$OLD_TH"'>/<group nthreads='"$NEW_TH"'>/' > netperf_$NEW_TH.xml
	#echo "$UPERF -m $WORKLOAD -a" >> $LOG_NET"_"$THREADS.log
	./uperf/src/uperf -m test-ssize-iperf.xml >> $LOG_NET"_"$THREADS.log
	echo "" >> $LOG_NET"_"$THREADS.log
	echo "-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-" >> $LOG_NET"_"$THREADS.log
	echo Finish in `date +%H:%M:%S--%d/%m/%Y` 2>&1>> $LOG_NET"_"$THREADS.log

}

network_2(){

	HOST=$1
	SIZE=$2
	REPET=$3
	echo "-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-" >> $LOG_NET"_"NTP.log
	echo Start in `date +%H:%M:%S--%d/%m/%Y` 2>&1>> $LOG_NET"_"NTP.log
	echo Index $4 >> $LOG_NET"_"NTP.log
	check_host >> $LOG_NET"_"NTP.log
	echo "" >> $LOG_NET"_"NTP.log
	#cat netperf_$OLD_TH.xml | sed 's/<group nthreads='"$OLD_TH"'>/<group nthreads='"$NEW_TH"'>/' > netperf_$NEW_TH.xml
	NPtcp -r -p 3 -h $HOST -n $REPET -u $SIZE -o ./logs/ntp.out &>> $LOG_NET"_"NTP.log
	echo "" >> $LOG_NET"_"NTP.log
	echo "-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-" >> $LOG_NET"_"NTP.log
	echo Finish in `date +%H:%M:%S--%d/%m/%Y` 2>&1>> $LOG_NET"_"NTP.log	
}

avoid_cache(){
	SIZE_FILE=$(echo $1)
	OPT=$2
	./linpack/linpack $OPT > /dev/null
	iozone -O -s $SIZE_FILE -r \#m -R > /dev/null
}

# func $HOST_to_Connect $upper_bound_stop_size $repet $INDEX
network_2 $NTP_HOST $NTP_SIZE 1000

for((THREADS=1; THREADS <= $MAX_THREAD; THREADS++))
do
	for((CONT=1; CONT <= $MAX_INDEX; CONT++))
	do
		#io $FILE_IOZONE $THREADS $CONT
		#proc $CRYPT_TYPE $THREADS $CONT 
		if [[ $THREADS == 1 ]]; then
			proc $ARRAY_PROC $THREADS $CONT
			io $FILE_IOZONE $THREADS $CONT
		fi		
		stream $ARRAY_MEM $THREADS $CONT
		avoid_cache 10240 1000
		#network $WORKLOAD_NET_TYPE $THREADS $CONT
	sleep 1
	done
done
