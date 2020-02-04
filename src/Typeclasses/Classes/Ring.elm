module Typeclasses.Classes.Ring exposing
    ( Ring
    , numberRing, trivialRing, exclusiveOrRing
    )

{-| Ring typeclass definition and its instances for basic types.


# Definition

@docs Ring

#Instances

@docs numberRing, trivialRing, exclusiveOrRing

-}

import Typeclasses.Classes.Group
import Typeclasses.Classes.Monoid


{-| Explicit typeclass which implements group operations for type `a`.
-}
type alias Ring a =
    { addition : Typeclasses.Classes.Group.Group a
    , multiplication : Typeclasses.Classes.Monoid.Monoid a
    }


numberRing : Ring number
numberRing =
    { addition = Typeclasses.Classes.Group.numberSum
    , multiplication = Typeclasses.Classes.Monoid.numberProduct
    }


trivialRing : Ring ()
trivialRing =
    { addition = Typeclasses.Classes.Group.trivialGroup
    , multiplication = Typeclasses.Classes.Monoid.unit
    }


exclusiveOrRing : Ring Bool
exclusiveOrRing =
    { addition = Typeclasses.Classes.Group.exclusiveOr
    , multiplication = Typeclasses.Classes.Monoid.all
    }
