this code collects and graphs data from a geiger-counter hooked up to a schmidt
trigger hooked up to a raspberry pi gpio pin.

this code can be found in the following places:
* https://github.com/mcthoren/particle_weather	<--code
* https://wx5.slackology.net/plots/particles.html	<--page
* https://wx5.slackology.net/			<--code, page, plots, data

specs on the tube used in this project (LND 712) can be found here:
* https://www.lndinc.com/products/geiger-mueller-tubes/712/

the german government also publishes measured radioactivity here:
* https://odlinfo.bfs.de/DE/index.html

notes:
* To make the numbers on the particle graphs more meaningful to more people,
we've started displaying our data in nGy/h instead of cpm. The datasheet for the
LND 712 (linked above) specifies "Gamma sensitivity Co60 (CPS/MR/HR): 18".  We
take this to suggest that 18 counts/s = 1 mR/h (for gamma radiation). I collect
data by counting per minute, therefore we divide the collected number of counts
counted every minute by 1080 (60s/m * 18 c/s/mR/h). We then multiply by 10 to go
from mR/h to uGy/h. Thus dividing our collected cpm data by 108 should yield
uGy/h. Because 1uGy/h is a large does rate relative to our background radiation,
we then multiply again by 1000 to put everything in nanograys/hour (nGy/h),
which is why in all our code you see our collected data multiplied by 1000/108.
If anyone finds this to be in error, please let me know. While the graphs are
displayed in nGy/h the raw collected data remains unconverted in counts per
minute.

* Gy are however a unit of dose, and I can't actually determine dose w.o.
knowing the energy of the incoming particles. Since i've calibrated the dose
measurements to Co60 (cuz that's the only data in the datasheet) we expect the
dose rate to read kinda high, and that's exactly what we see when we compare my
data to the german gov measurements.

* This geiger tube is also somewhat unique in that it's an alpha, beta, and
gamma tube, and my calibration is only against a gamma source.

* This station has been moved a number of times over the years. As environmental
background radiation is different everywhere, these moves are visible in the
data.

** 2007-01-06: First set up in Seattle, Washington.
** 2007-03-06: Moved to it's final location at the first Apartment.
** 2011-07-05: Moved to second Seattle Apt, which was made of brick, which was
visible in the data.
