module Main
( main
) where

import Prelude
import Control.Monad.Eff (Eff)
import Onion (h, HTML, run, t)

counter :: forall eff. Int -> (Int -> Eff eff Unit) -> HTML eff
counter n u = h "div" {onclick: u (n + 1)} [t (show n)]

main :: forall eff. Eff eff Unit
main = run 0 counter
