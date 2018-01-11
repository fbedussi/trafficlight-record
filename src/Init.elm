module Init exposing (..)

import Json.Encode exposing (..)
import Models exposing (FirebaseCmd, Model, resetModel)
import Msgs exposing (Msg)
import Navigation exposing (Location)
import Routing exposing (parseLocation)


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            parseLocation location
    in
    ( resetModel currentRoute, Cmd.none )
