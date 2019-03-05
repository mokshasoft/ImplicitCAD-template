gen: build
	stack exec implicitcad-template
build: DoubleSpiral.hs MagicDice.hs Main.hs
	stack build
