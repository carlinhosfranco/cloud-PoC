set encoding utf8
set terminal postscript eps solid color font 'Helvetica,20'
set output 'processamento.eps'
set style data dots
#set encoding iso_8859_1
#set key outside left bottom horizontal Left reverse enhanced autotitles nobox

#Configurar Margens
#set tmargin 3.3
#set bmargin 2
#set lmargin 8
#set rmargin 1

#set grid
set boxwidth 0.3
set xrange [-1:3]
#set x2range [0:2]
#set xtics  2
#set yrange [0:10]
#set y2range [0:200]
#set y3range [0:200]
#set ytics 0,2
#set mytics 5
set yrange [0:700]
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

set style fill solid 0.5 border 

set key inside top vertical nobox font 'Helvetica,20'
set title "LINPACK" 
set ylabel "MFLOPS" offset 1,1,1
set xlabel "Threads"
#set xtics ("" 1, "" 3, "" 5, "" 7) font 'Helvetica,12'
#set ytics 200
#set style fill transparent pattern 3 border
#set multiplot layout 1,1

plot './proc.dat' using 1:($2/1024):xtic(1) with boxes ls 6 title "FLOPS" axes x1y1, '' using 1:($2/1024):3 with errorbars ls 1 title "Erro"
#plot './proc.dat' using 1:2:xtic(1) with boxes ls 6 title "FLOPS" axes x1y1, '' using 1:2:3 with errorbars ls 1 title "Erro"

