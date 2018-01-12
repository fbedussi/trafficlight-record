port module Firebase exposing (..)

import Json.Decode
import Models exposing (..)


port sendCmdToFirebasegit Db : FirebaseCmd -> Cmd msg


port sendCmdToFirebaseAuth : FirebaseCmd -> Cmd msg


port listenToFirebaseDbResponse : (Json.Decode.Value -> msg) -> Sub msg


port listenToFirebaseAuthResponse : (Json.Decode.Value -> msg) -> Sub msg
