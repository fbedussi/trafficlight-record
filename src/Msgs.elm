module Msgs exposing (..)

import Models exposing (Color, Data, Direction)
import Navigation exposing (Location)


type Msg
    = OnLocationChange Location
    | ChangeLocation String
    | NewData (Result String Data)
    | RegisterColor Direction Color
