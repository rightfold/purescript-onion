module Main
( main
) where

import Control.Monad.Eff (Eff)
import Onion (run)
import Onion.HTML (HTML, text, unsafeElement)
import Prelude

counter :: forall eff. Int -> (Int -> Eff eff Unit) -> HTML eff
counter n u = unsafeElement "div" {onclick: u (n + 1)} [text (show n)]

main :: forall eff. Eff eff Unit
main = run 0 counter
