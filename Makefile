all:
	lazbuild --lazarusdir=/usr/lib/lazarus -B mht2htm.lpi

clean:
	@rm -vfr lib mht2htm
