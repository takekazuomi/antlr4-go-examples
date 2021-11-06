ANTLR4=docker run --rm -it -u $$(id -u $${USER}):$$(id -g $${USER}) -v $$(pwd):/work antlr/antlr4
PARSER_GO=parser/json_lexer.go parser/json_listener.go parser/json_parser.go parser/json_base_listener.go

.DEFAULT_GOAL := help

help:           ## show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

build:		## build
build: main.go $(PARSER_GO)
	go build -o bin/try-antlr401 main.go

run:		## run with json/input.json
run: main.go $(PARSER_GO)
	go run main.go json/input.json

$(PARSER_GO): parser/JSON.g4
	cd parser; $(ANTLR4) -Dlanguage=Go JSON.g4

