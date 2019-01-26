
STEPS = setversion mkchangelog mkdocs mktar

FILES = findimagedupes COPYING README 
EPHEMERAL = history README VERSION

.PHONY: $(STEPS) clean

all: $(STEPS)

clean:
	git checkout -f

reallyclean:
	git clean -d -f


setversion:
	git describe --tags > VERSION
	./patchver 

mkchangelog:
	git log --decorate=short > history

mkdocs:
	perldoc findimagedupes > README

mktar:
	tar cvzf findimagedupes-`cat VERSION`.gz $(FILES)

