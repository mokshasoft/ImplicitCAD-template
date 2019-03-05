module MagicDice
    ( magicDice
    , runMagicDice
    ) where

import Graphics.Implicit
import Graphics.Implicit.Definitions

gr = (1 + sqrt 5)/2
d90 = 2*pi/4

roundedCornerSlicer :: ℝ -> SymbolicObj3
roundedCornerSlicer r =
    difference
        [ rect3R 0 (0, 0, 0) (2*r, 2*r, 2*r)
        , sphere r
        ]

roundedCube :: ℝ -> ℝ -> SymbolicObj3
roundedCube s r =
    difference $
        [ translate (-s/2, -s/2, -s/2) $ rect3R r (0, 0, 0) (s, s, s)
        ] ++
        map (\a -> rotate3(0, 0, a*d90) cornerRounder) [0..3] ++
        map (\a -> rotate3(2*d90, 0, a*d90) cornerRounder) [0..3]
  where
    cornerRounder = translate (s/2 - r, s/2 - r, s/2 - r) $ roundedCornerSlicer r

sixFace :: ℝ -> ℝ -> SymbolicObj3
sixFace s r =
    union $
        map (\k -> translate (dx*fromIntegral (k `div` 2) - dx,
                              dy*fromIntegral (k `mod` 2) - dy/2,
                              0) $ sphere r) faces
  where
    l = s/gr - r
    dx = l/2
    dy = l/gr
    faces = [0..5] :: [Integer]

magicDice :: ℝ -> SymbolicObj3
magicDice s  =
    difference
        [ roundedCube s r
        , rotate3 (0, 0, d90) $ translate (0, 0, s2) $ sixFace s r
        , rotate3 (0, 0, d90) $ translate (0, 0, -s2) $ sixFace s r
        , translate (s2, 0, 0) $ rotate3 (0, d90, 0) $ sixFace s r
        , translate (-s2, 0, 0) $ rotate3 (0, d90, 0) $ sixFace s r
        , translate (0, s2, 0) $ rotate3 (d90, 0, 0) $ sixFace s r
        , translate (0, -s2, 0) $ rotate3 (d90, 0, 0) $ sixFace s r
        ]
  where
    r = s/10/gr
    s2 = s/2 + r/gr

runMagicDice :: IO ()
runMagicDice =
    writeSTL 1 "dice.stl" $ magicDice 30
