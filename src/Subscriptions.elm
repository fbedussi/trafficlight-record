module Subscriptions exposing (..)

import Firebase exposing (listenToFirebaseResponse)
import Models exposing (Model)
import Msgs exposing (Msg)


subscriptions : Model -> Sub Msg
subscriptions model =
    listenToFirebaseResponse Msgs.NewData
