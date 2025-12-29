set y2tics
set mytics
set key outside below
set xdata time
set xlabel "Time (UTC)" offset 0.0, -1.6
set format x "%F\n%TZ"
set timefmt "%Y-%m-%dT%H:%M:%SZ"
set grid
set xtics 7200 rotate by 30 offset -5.9, -2.2
set mxtics
set grid mxtics
set grid
set link y2
set ylabel "nGy/h"
set y2label "nGy/h"
set term svg size 2000, 512 font ",12" background "0xffffff"

# for the lnd 712 we think the conversion factor between collected cpm data and nano grays per hours is 1000/108 for Co60.
# http://www.lndinc.com/products/348/  <--"Gamma sensitivity Co60 (cps/mr/hr)   18"
# ^--or at least that's the sense we have from the above
# which is likely going to yield a higher dose rate than what we're actually seeing, as Co60 is prly
# not the typical isotope that we measure here in my apt.

p_dat='/home/ghz/repos/particle_weather/data/particle.dat.2-3_day'
day_dat='/home/ghz/repos/particle_weather/data/particle.dat.day_avg'
mon_dat='/home/ghz/repos/particle_weather/data/particle.dat.month_avg'
plot_d='/home/ghz/repos/particle_weather/plots'

set title "Radioactivity over the last \\~48 hours."
set output plot_d."/particle_cpm_48.svg"
plot p_dat using 1:(($2*1000/108)) title 'Dose Rate (nGy/h)' with points linecolor rgb "#00f000",\
p_dat using 1:(($2*1000/108)) title 'Dose Rate bezier smoothed' with lines lw 2 linecolor rgb "#f00000" smooth bezier

set title "Radioactivity: Daily averages."
set xlabel "Date (UTC)" offset 0.0, -1.6
set format x "%F"
set output plot_d."/particle_cpm_da.svg"
set xrange [:] noextend
set xtics auto rotate by 30 offset -6.8, -2.2
set mxtics 2
set grid mxtics
set xtics out
set ytics out
set style fill solid 0.50 noborder
plot day_dat using 1:(($2*1000/108)) title 'Daily Average Dose Rates (nGy/h)' with boxes linecolor rgb "#00aa00"

set title "Radioactivity: Daily averages for the last 45 days."
set output plot_d.'/particle_cpm_da.45.svg'
plot day_dat.".45" using 1:(($2*1000/108)) title 'Daily Average Dose Rates (nGy/h)' with boxes linecolor rgb "#0000ff"

set timefmt "%Y-%m"
set title "Radioactivity: Monthly averages."
set output plot_d.'/particle_cpm_month_avg.svg'
plot mon_dat using 1:(($2*1000/108)) title 'Monthly Average Dose Rates (nGy/h)' with boxes linecolor rgb "#00c0c0"

set xrange ["2023-01":] noextend
set title "Radioactivity: Monthly averages since last move."
set output plot_d.'/particle_cpm_month_avg.slm.svg'
plot mon_dat using 1:(($2*1000/108)) title 'Monthly Average Dose Rates (nGy/h)' with boxes linecolor rgb "#00c0c0"

set xrange ["2023-01-07":] noextend
set title "Radioactivity: Daily averages since last move."
set timefmt "%Y-%m-%dT%H:%M:%SZ"
set output plot_d."/particle_cpm_da.slm.svg"
plot day_dat using 1:(($2*1000/108)) title 'Daily Average Dose Rates (nGy/h)' with boxes linecolor rgb "#00aa00"
