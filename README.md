# ImplicitCAD Template
This is a Stack template that shows how to use the ImplicitCAD Haskell library. ImplicitCAD (implicitcad.org) is an open-source programmatic CAD library written in Haskell.

# Building
\$ stack build

# Generating CSG
\$ stack exec implicitcad-template

# Viewing the Output
The example generates to output files one svg file and one stl file. The svg file can be viewed with a browser and the stl file can be viewed with meshlab.
\$ firefox helloworld.svg
\$ meshlab helloworld.stl


