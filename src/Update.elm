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

        NewData (Ok data) ->
            ( { model | data = data }, Cmd.none )

        NewData (Err _) ->
            ( model, Cmd.none )

        RegisterColor direction color ->
            ( updateColorInModel model direction color, Cmd.none )


updateColorInModel : Model -> Direction -> Color -> Model
updateColorInModel model direction color =
    let
        newData =
            model.data
    in
    { model
        | data =
            case direction of
                North ->
                    { newData | north = List.append model.data.north [ color ] }

                South ->
                    { newData | south = List.append model.data.south [ color ] }

                East ->
                    { newData | east = List.append model.data.east [ color ] }

                West ->
                    { newData | west = List.append model.data.west [ color ] }
    }
