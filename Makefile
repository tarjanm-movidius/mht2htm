all:
	lazbuild --verbose -B mht2htm.lpi

# The following copied&pasted from lazbuild prints, altered flags for profiling
release:
	@mkdir -vp ./lib/x86_64-linux/
	/usr/bin/fpc -B -MObjFPC -CX -Cg -O3 -OoREGVAR -Xs -XX -l -vewnhibq -Fi./lib/x86_64-linux -Fu/usr/lib/lazarus/lcl/units/x86_64-linux/gtk2 -Fu/usr/lib/lazarus/lcl/units/x86_64-linux -Fu/usr/lib/lazarus/components/freetype/lib/x86_64-linux -Fu/usr/lib/lazarus/components/lazutils/lib/x86_64-linux -Fu/usr/lib/lazarus/packager/units/x86_64-linux -Fu./ -FU./lib/x86_64-linux/ -FE./ -o./mht2htm -dLCL -dLCLgtk2 mht2htm.lpr

debug:
	@mkdir -vp ./lib/x86_64-linux/
	/usr/bin/fpc -B -MObjFPC -CX -Cg -O3 -OoREGVAR -g -pg -XX -l -vewnhibq -Fi./lib/x86_64-linux -Fu/usr/lib/lazarus/lcl/units/x86_64-linux/gtk2 -Fu/usr/lib/lazarus/lcl/units/x86_64-linux -Fu/usr/lib/lazarus/components/freetype/lib/x86_64-linux -Fu/usr/lib/lazarus/components/lazutils/lib/x86_64-linux -Fu/usr/lib/lazarus/packager/units/x86_64-linux -Fu./ -FU./lib/x86_64-linux/ -FE./ -o./mht2htm -dLCL -dLCLgtk2 mht2htm.lpr

gprof:
	@[ -e prof.txt ] && [ -d backup ] && mv -v prof.txt backup
	gprof -c --inline-file-names mht2htm gmon.out > prof.txt

clean:
	@rm -vfr lib mht2htm
