#!/bin/sh
# Assumes "pandoc" and "weasyprint" have been installed (available from EPEL).

s=specification
html=$s.html

pandoc --ascii -o $html -css $s.css $s.md &&
    perl -i -pe '
	s/(href="#)(\d+-)/$1s$2/;
	if (s/^(<h[1-6] +id=")([^"]+">)((\d+\.)+)/$1s$3-$2$3/) {
	    while (s/^(<h[1-6] +id="[^"]*)\./$1/) {
	    }
	}
    ' $html &&
    ls -l $html || exit

pdf=$s.pdf

weasyprint $html $pdf && ls -l $pdf

