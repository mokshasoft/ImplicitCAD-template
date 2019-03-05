module DoubleSpiral
    ( runDoubleSpiral
    ) where

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

runDoubleSpiral :: IO ()
runDoubleSpiral = do
    writeSVG 2 "doublespiral.svg" $ createIntersection 30
    writeSTL 1 "doublespiral.stl" $ createSpiral 30
