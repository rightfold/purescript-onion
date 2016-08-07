module Onion.HTML
( HTML
, element
, text

, Prop
, unsafeProp

, button

, onclick
) where

import Control.Monad.Eff (Eff)
import Prelude

foreign import data HTML :: # ! -> *

element :: forall eff. String -> Array (Prop eff) -> Array (HTML eff) -> HTML eff
element = _element

text :: forall eff. String -> HTML eff
text = _text

foreign import data Prop :: # ! -> *

unsafeProp :: forall eff a. String -> a -> Prop eff
unsafeProp = _unsafeProp

--------------------------------------------------------------------------------
-- Elements --------------------------------------------------------------------
--------------------------------------------------------------------------------

button :: forall eff. Array (Prop eff) -> Array (HTML eff) -> HTML eff
button = element "button"

--------------------------------------------------------------------------------
-- Properties ------------------------------------------------------------------
--------------------------------------------------------------------------------

onclick :: forall eff. Eff eff Unit -> Prop eff
onclick = unsafeProp "onclick"

foreign import _element :: forall eff. String -> Array (Prop eff) -> Array (HTML eff) -> HTML eff
foreign import _text :: forall eff. String -> HTML eff
foreign import _unsafeProp :: forall eff a . String -> a -> Prop eff
