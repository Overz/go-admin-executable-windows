GO=go
GOBUILD=$(GO) build
GOINSTALL=$(GO) install
GOARCH=amd64
GOOS=windows

LDFLAGS=-w -s -extldflags "-static"

CMDNAME=hello
SOURCES=$(shell find . -type f -name "*.go") go.mod

MANIFEST=hello.exe.manifest
RSRC=rsrc
RSRC_OUT=hello.syso
RSRC_MANIFEST=-manifest $(MANIFEST)


all: build

build: $(CMDNAME)

$(CMDNAME): $(SOURCES)
	$(RSRC) $(RSRC_MANIFEST) -o $(RSRC_OUT)
	$(GOBUILD) -o $(CMDNAME) -ldflags '$(LDFLAGS)' ./$(CMDNAME).go
	GOOS=$(GOOS) GOARCH=$(GOARCH) $(GOBUILD) -o $(CMDNAME).exe -ldflags '$(LDFLAGS)' ./$(CMDNAME).go

clean:
	rm -rf $(CMDNAME) $(CMDNAME).exe $(CMDNAME).syso

.PHONY: all build clean