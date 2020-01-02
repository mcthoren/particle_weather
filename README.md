This code collects and graphs data from a Geiger-counter hooked up to a Schmidt
trigger hooked up to a raspberry pi GPIO pin.

this code can be found in the following places:
* https://github.com/mcthoren/particle_weather		<--code
* https://wx5.slackology.net/plots/particles.html	<--page
* https://wx5.slackology.net/				<--code, page, plots, data

Specs on the tube used in this project (LND 712) can be found here:
* https://www.lndinc.com/products/geiger-mueller-tubes/712/

The German government also publishes measured radioactivity here:
* https://odlinfo.bfs.de/DE/index.html

Notes:
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
knowing the energy of the incoming particles. Since I've calibrated the dose
measurements to Co60 (cuz that's the only data in the datasheet) we expect the
dose rate to read kinda high, and that's exactly what we see when we compare my
data to the German gov measurements.

* This Geiger tube is also somewhat unique in that it's an alpha, beta, and
gamma tube, and my calibration is only against a gamma source.

* This station has been moved a number of times over the years. As environmental
background radiation is different everywhere, these moves are visible in the
data.
	* 2007-01-06: First set up in Seattle, Washington.
	* 2007-03-06: Moved to it's final location at the first apartment in Seattle.
	* 2011-07-05: Moved to second apt in Seattle, which was made of brick, which was visible in the data.
	* 2012-09-14: Got torn down for a move to another country, NO DATA until...
	* 2014-05-04: Finally managed to get life stable enough to set everything back up in the tiny concrete box I was living in Kiel, N. Germany.
	* 2015-05-02: Moved out of the concrete box and into an Apt, still in Kiel. NO DATA until...
	* 2015-05-26: Got everything back up and running on the inside of an external wall, which was made of brick.
	* 2015-07-26: Moved the Geiger counter away from the external wall, and toward the interior of the room.
	* 2016-03-20: Moved back to the concrete box, was happy to see levels were the same as the first time I lived in the box. Yay repeatable data.
	* 2016-10-28: GTFO of Kiel. NO DATA until...
	* 2016-11-15: Finally got to Berlin. Lived there until...
	* 2018-11-20: Tore everything done and moved once more. NO DATA until...
	* 2018-12-14: Got everything set back up on the balcony of an apt in Augsburg, Germany - a small town in Bavaria.
	* 2019-03-31: Moved the Geiger counter to the bottom shelf of a plant thing on the balcony.
