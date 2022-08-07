
### mht2htm Makefile

FPC:=/usr/bin/fpc
PFLAGS:=-B -MObjFPC -CX -Cg -O3 -OoREGVAR -l -vewnhibq -Fi./lib/x86_64-linux -Fu/usr/lib/lazarus/lcl/units/x86_64-linux/gtk2 -Fu/usr/lib/lazarus/lcl/units/x86_64-linux -Fu/usr/lib/lazarus/components/freetype/lib/x86_64-linux -Fu/usr/lib/lazarus/components/lazutils/lib/x86_64-linux -Fu/usr/lib/lazarus/packager/units/x86_64-linux -Fu./ -FU./lib/x86_64-linux/ -FE./ -o./mht2htm -dLCL -dLCLgtk2
LPRFILE:=mht2htm.lpr

all: mklibdir
	$(FPC) -Xs -XX $(PFLAGS) $(LPRFILE)

laz:
	lazbuild --verbose -B mht2htm.lpi

# The following copied&pasted from lazbuild prints, altered flags for profiling
release: mklibdir
	$(FPC) -Xs $(PFLAGS) $(LPRFILE)

debug: mklibdir
	$(FPC) -g -pg $(PFLAGS) $(LPRFILE)

mklibdir:
	@mkdir -vp ./lib/x86_64-linux/

gprof:
	@[ -e prof.txt ] && [ -d backup ] && mv -v prof.txt backup || true
	gprof -c --inline-file-names mht2htm gmon.out > prof.txt

clean:
	@rm -vfr lib mht2htm
