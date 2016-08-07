module Main
( main
) where

import Control.Monad.Eff (Eff)
import Onion (run)
import Onion.HTML (button, HTML, onclick, text)
import Prelude

counter :: forall eff. Int -> (Int -> Eff eff Unit) -> HTML eff
counter n u = button [onclick (u (n + 1))] [text (show n)]

main :: forall eff. Eff eff Unit
main = run 0 counter
