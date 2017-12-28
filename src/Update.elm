module Update exposing (update)

import Helpers exposing (..)
import Init exposing (init)
import Models exposing (..)
import Msgs exposing (..)
import Navigation exposing (newUrl)
import Routing exposing (parseLocation)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeLocation path ->
            ( model, newUrl path )

        OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
            ( Model
                newRoute
                model.data
            , Cmd.none
            )

        NewData data ->
            ( { model | data = data }, Cmd.none )
