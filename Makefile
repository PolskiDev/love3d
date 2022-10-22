all:
	zip -r game.love .
run: all
	love game.love