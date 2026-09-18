.PHONY: run run-jar serve

run:
	@java -Djava.library.path=lib/game-backend/jars/natives --enable-native-access=ALL-UNNAMED -jar $$(which keen) run main.keen -- $(ARGS)

game.jar:
	keen build main.keen --out game.jar

run-jar:
	@java -Djava.library.path=lib/game-backend/jars/natives --enable-native-access=ALL-UNNAMED --sun-misc-unsafe-memory-access=allow -jar game.jar

serve: index.js
	( trap 'kill 0' INT; keen build main.keen --out index.js --watch & keen serve.keen & wait )

index.js: *.keen
	keen build main.keen --out index.js
