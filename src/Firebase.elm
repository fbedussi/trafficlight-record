port module Firebase exposing (..)

import Models exposing (Data, FirebaseCmd)


port sendCmdToFirebase : FirebaseCmd -> Cmd msg


port listenToFirebaseResponse : (Data -> msg) -> Sub msg
