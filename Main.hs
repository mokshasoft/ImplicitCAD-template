module Main where

import Graphics.Implicit
import Graphics.Implicit.Definitions

gr = (1 + sqrt 5)/2

createIntersection :: ℝ -> SymbolicObj2
createIntersection r =
    unionR (r/2/gr)
        [ translate (-r, 0) $ circle r
        , translate (r, 0) $ circle r
        ]

createSpiral :: ℝ -> SymbolicObj3
createSpiral l = extrudeRM 0 (Just id) Nothing Nothing (createIntersection l) (Left 360)

main :: IO ()
main = do
    writeSVG 2 "helloworld.svg" $ createIntersection 30
    writeSTL 1 "helloworld.stl" $ createSpiral 30
