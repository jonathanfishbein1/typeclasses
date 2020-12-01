module CommutativeMonoid exposing
    ( CommutativeMonoid(..)
    , numberProduct, intProduct, numberSum, intSum, unit, modularArithmetic, all, any, exclusiveOr, commutativeSemigroupAndIdentity
    )

{-| Commutative Monoid typeclass definition and its instances for basic types.


# Definition

@docs CommutativeMonoid


# Instances

@docs numberProduct, intProduct, numberSum, intSum, unit, modularArithmetic, all, any, exclusiveOr, commutativeSemigroupAndIdentity

-}

import CommutativeSemigroup


{-| Explicit typeclass which implements monoid operations for type `a` when the operation is commutative.
-}
type CommutativeMonoid a
    = CommutativeMonoid
        { semigroup : CommutativeSemigroup.CommutativeSemigroup a
        , identity : a
        , concat : List a -> a
        }


{-| Construct an instance by specifying a commutative semigroup instance and an identity value.
-}
commutativeSemigroupAndIdentity : CommutativeSemigroup.CommutativeSemigroup a -> a -> CommutativeMonoid a
commutativeSemigroupAndIdentity commutativeSemigroup identity =
    let
        (CommutativeSemigroup.CommutativeSemigroup semigroup) =
            commutativeSemigroup
    in
    { semigroup = commutativeSemigroup
    , identity = identity
    , concat = List.foldl semigroup identity
    }
        |> CommutativeMonoid


{-| Construct an instance for any type which satisfies Elm's `number` magic constraint.
Implements multiplication.
-}
numberProduct : CommutativeMonoid number
numberProduct =
    { semigroup = CommutativeSemigroup.numberProduct, identity = 1, concat = List.product }
        |> CommutativeMonoid


{-| Construct an instance for any type which satisfies Elm's `number` magic constraint.
Implements sum.
-}
numberSum : CommutativeMonoid number
numberSum =
    { semigroup = CommutativeSemigroup.numberSum, identity = 0, concat = List.sum }
        |> CommutativeMonoid


{-| Instance for integers under the multiplication operation.
-}
intProduct : CommutativeMonoid Int
intProduct =
    numberProduct


{-| Instance for integers under the sum operation.
-}
intSum : CommutativeMonoid Int
intSum =
    numberSum


{-| Instance for all
-}
all : CommutativeMonoid Bool
all =
    commutativeSemigroupAndIdentity CommutativeSemigroup.and True


{-| Instance for any
-}
any : CommutativeMonoid Bool
any =
    commutativeSemigroupAndIdentity CommutativeSemigroup.or False


{-| Instance for trivial monoid
-}
unit : CommutativeMonoid ()
unit =
    commutativeSemigroupAndIdentity CommutativeSemigroup.unit ()


{-| Instance for exclusiveOr
-}
exclusiveOr : CommutativeMonoid Bool
exclusiveOr =
    commutativeSemigroupAndIdentity CommutativeSemigroup.xor False


{-| Instance for modularArithmetic
-}
modularArithmetic : Int -> CommutativeMonoid Int
modularArithmetic divisor =
    commutativeSemigroupAndIdentity (CommutativeSemigroup.modularArithmetic divisor) 0