
STEPS = setversion mkchangelog mkdocs mktar

FILES = findimagedupes COPYING README 
EPHEMERAL = changelog README VERSION

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
	git log > changelog

mkdocs:
	perldoc findimagedupes > README

mktar:
	tar cvzf findimagedupes-`cat VERSION`.gz $(FILES)

