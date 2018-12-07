set encoding utf8
set terminal postscript eps solid color font 'Helvetica,20'
set output 'io.eps'
set style data dots
#set encoding iso_8859_1
#set key outside left bottom horizontal Left reverse enhanced autotitles nobox
set grid
set boxwidth 0.3
set xrange [-1:6]
#set x2range [0:2]
#set xtics  2

#set y2range [0:200]
#set y3range [0:200]
set ytics 100000
set yrange [1000:700000]
#set mytics 5


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
#set style fill transparent pattern 6 border
#for than on graph
#set style fill solid 0.25 border
#set multiplot layout 2,2

set key inside top vertical nobox font 'Helvetica,20'
#set title "IOZONE" offset -2,-1,1
set ylabel "Operações por Segundo" offset 1,1,1
#set xlabel "OPS" offset 1,1,1
#set xtics rotate by -60 ("Writer" 1, "Re-writer" 2, "Reader" 3, "Re-Reader" 4, "Random Read" 5, "Random Write" 6, "Backward Read" 7, "Record Rewrite" 8, "Stride Read" 9, "Fwrite" 10, "Re-Fwrite" 11, "Fread" 12, "Re-Fread" 13) font 'Helvetica,12'
set xtics rotate by -60 ("Writer" 0, "Re-writer" 1, "Reader" 2, "Re-Reader" 3, "Random Read" 4, "Random Write" 5) font 'Helvetica,12'

plot './io_full.dat' using 1:2 with boxes ls 6 title "Operação" axes x1y1, '' using 1:2:3 with errorbars ls 1 title "Erro"

