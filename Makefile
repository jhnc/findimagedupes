
STEPS = github dist all

FILES = findimagedupes COPYING README 
EPHEMERAL = history README VERSION

.PHONY: $(STEPS) clean

README.md: findimagedupes
	pod2markdown findimagedupes README.md
	git add README.md
	git commit -m 'regenerate github readme'

github: README.md
	git push github

all: dist

clean:
	git checkout -f

reallyclean:
	git clean -d -f

dist:
	git describe --tags > VERSION
	./patchver 
	git log --decorate=short > history
	perldoc findimagedupes > README
	tar cvzf findimagedupes-`cat VERSION`.gz $(FILES)
	rm $(EPHEMERAL)

