module Onion.HTML
( HTML
, unsafeElement
, text
) where

foreign import data HTML :: # ! -> *

unsafeElement :: forall eff p. String -> Record p -> Array (HTML eff) -> HTML eff
unsafeElement = _unsafeElement

text :: forall eff. String -> HTML eff
text = _text

foreign import _unsafeElement :: forall eff p. String -> Record p -> Array (HTML eff) -> HTML eff
foreign import _text :: forall eff. String -> HTML eff
