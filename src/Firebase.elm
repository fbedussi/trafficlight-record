port module Firebase exposing (..)

import Json.Decode
import Models exposing (..)


port sendCmdToFirebase : FirebaseCmd -> Cmd msg


port listenToFirebaseResponse : (Json.Decode.Value -> msg) -> Sub msg
