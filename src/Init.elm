module Init exposing (..)

import Firebase exposing (sendCmdToFirebase)
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

        readAllPayload =
            object
                [ ( "storeName", string "data" )
                ]
    in
    ( resetModel currentRoute
    , sendCmdToFirebase (FirebaseCmd "readAll" (encode 0 readAllPayload))
    )
