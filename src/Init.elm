module Init exposing (..)

import Firebase exposing (sendCmdToFirebase)
import Models exposing (Model, resetModel)
import Msgs exposing (Msg)
import Navigation exposing (Location)
import Routing exposing (parseLocation)


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            parseLocation location
    in
    ( resetModel currentRoute
    , sendCmdToFirebase { name = "readAll" }
    )
