
STEPS = github dist all

FILES = findimagedupes COPYING README.md history
EPHEMERAL = history VERSION

.PHONY: $(STEPS) clean

README.md: findimagedupes
	pod2markdown findimagedupes README.md
	git add README.md
	git commit -m 'synchronise README.md with findimagedupes source' || true

github: README.md
	git push github main

all: dist

clean:
	git checkout -f

reallyclean:
	git clean -d -f

dist: README.md
	git describe --tags > VERSION
	./patchver 
	git log --decorate=short --simplify-by-decoration -- findimagedupes | grep -v '^Author:' > history
	tar cvzf findimagedupes-`cat VERSION`.tar.gz $(FILES)
	git checkout findimagedupes
	rm $(EPHEMERAL)

