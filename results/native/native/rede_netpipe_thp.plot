set encoding utf8
set terminal postscript eps solid color font 'Helvetica,20'
set output 'rede_netpipe.eps'

set key outside right top horizontal autotitles nobox
#set grid

set style line 1 lt 1 lc rgb "#FF0000" lw 1.5           #red
set style line 2 lt 3 lc rgb "#8B0000" lw 1.5           #darkred
set style line 3 lt 3 lc rgb "#DC143C" lw 1.5           #crison
set style line 4 lt 4 lc rgb "#800000" lw 1.5           #maroon

set style line 6 lt 6 lc rgb "#000080" lw 1.5           #navy
set style line 7 lt 3 lc rgb "#4169E1" lw 1.5           #navy_blue
set style line 8 lt 3 lc rgb "#1E90FF" lw 1.5           #dodgerblue
set style line 9 lt 4 lc rgb "#0000FF" lw 1.5           #blue

set style line 10 lt 1 lc rgb "#228B22" lw 1.5           #forestgreen
set style line 11 lt 3 lc rgb "#006400" lw 1.5           #darkgree
set style line 12 lt 3 lc rgb "#008000" lw 1.5           #green
set style line 13 lt 4 lc rgb "#0000" lw 1.5           #mediumseagreen

set yrange [-15:]
set logscale x

#set xtics 5
#set style fill solid 0.5 border 
#set xtics (1,2,4,8,16,32,64,128,256,512,1024)
set title "NetPIPE" 
set xlabel "Tamanho do Pacote" 
set ylabel "Mbps" offset 1,1,1
#set xtics ("0" 0, "" 0.1, "." 0.2, "." 0.3, "." 0.4, "." 0.5, "." 0.6, "." 0.7, "." 0.8, "1" 1, "2" 2, "4" 4, "6" 6, "8" 8) font 'Helvetica,12'

plot './all_logs/ntp.out' using 1:2 with lines ls 6 title "Throughput" axes x1y1
#'./native/net_NTP.log' using 2:10 with lines ls 1 lw 1.2 title "Latência" axes x1y2


