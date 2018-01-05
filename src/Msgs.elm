module Msgs exposing (..)

import Models exposing (Color, Data, Direction)
import Navigation exposing (Location)
import Time exposing (Time)


type Msg
    = OnLocationChange Location
    | ChangeLocation String
    | NewData (Result String Data)
    | HandleClick Direction Color
    | RegisterColor Direction Color Time
