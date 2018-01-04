module Update exposing (update)

import Firebase exposing (sendCmdToFirebase)
import Helpers exposing (..)
import Init exposing (init)
import Json.Encode exposing (..)
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
            let
                updatedData =
                    updateData model.data direction color

                createPayload =
                    object
                        [ ( "storeName", string ("data/" ++ (direction |> toString |> String.toLower)) )
                        , ( "content", string (color |> toString |> String.toLower) )
                        ]
            in
            ( { model | data = updatedData }, sendCmdToFirebase (FirebaseCmd "create" (encode 0 createPayload)) )


updateData : Data -> Direction -> Color -> Data
updateData data direction color =
    case direction of
        North ->
            { data | north = List.append data.north [ color ] }

        South ->
            { data | south = List.append data.south [ color ] }

        East ->
            { data | east = List.append data.east [ color ] }

        West ->
            { data | west = List.append data.west [ color ] }
