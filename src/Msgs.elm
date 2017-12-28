module Msgs exposing (..)

import Models exposing (Data)
import Navigation exposing (Location)


type Msg
    = OnLocationChange Location
    | ChangeLocation String
    | NewData Data
