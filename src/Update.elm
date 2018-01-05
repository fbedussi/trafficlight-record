module Update exposing (update)

import Firebase exposing (sendCmdToFirebase)
import Helpers exposing (..)
import Init exposing (init)
import Json.Encode exposing (..)
import Models exposing (..)
import Msgs exposing (..)
import Navigation exposing (newUrl)
import Routing exposing (parseLocation)
import Task
import Time exposing (Time)


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

        NewData (Err error) ->
            let
                log =
                    Debug.log "newData error" error
            in
            ( model, Cmd.none )

        HandleClick direction color ->
            ( model, Task.perform (RegisterColor direction color) Time.now )

        RegisterColor direction color time ->
            let
                newPassageData =
                    PassageData time color

                encodedNewPassageData =
                    object
                        [ ( "time", float time )
                        , ( "color", color |> toString |> String.toLower |> string )
                        ]

                updatedData =
                    updateData model.data direction newPassageData

                createPayload =
                    object
                        [ ( "storeName", string ("data/" ++ (direction |> toString |> String.toLower)) )
                        , ( "content", string (encode 0 encodedNewPassageData) )
                        ]
            in
            ( { model | data = updatedData }, sendCmdToFirebase (FirebaseCmd "create" (encode 0 createPayload)) )


updateData : Data -> Direction -> PassageData -> Data
updateData data direction newPassageData =
    case direction of
        North ->
            { data | north = List.append data.north [ newPassageData ] }

        South ->
            { data | south = List.append data.south [ newPassageData ] }

        East ->
            { data | east = List.append data.east [ newPassageData ] }

        West ->
            { data | west = List.append data.west [ newPassageData ] }
