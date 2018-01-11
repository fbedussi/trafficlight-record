module Update exposing (update)

import Firebase exposing (sendCmdToFirebaseAuth, sendCmdToFirebaseDb)
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
            ( { model | route = newRoute }, Cmd.none )

        UpdateLoginData loginField value ->
            let
                newLoginData =
                    model.loginData
            in
            case loginField of
                Email ->
                    ( { model | loginData = { newLoginData | email = value } }, Cmd.none )

                Password ->
                    ( { model | loginData = { newLoginData | password = value } }, Cmd.none )

        Login ->
            let
                loginPayload =
                    object
                        [ ( "method", string "email" )
                        , ( "email", string model.loginData.email )
                        , ( "password", string model.loginData.password )
                        ]
            in
            ( model, sendCmdToFirebaseAuth (FirebaseCmd "logIn" (encode 0 loginPayload)) )

        NewUser (Ok userUid) ->
            ( Model
                Home
                model.data
                model.loginData
                userUid
            , Task.perform (Task.sequence [ OpenDb |> Task.succeed, ReadAllData |> Task.succeed ]) Time.now
            )

        OpenDb ->
            let
                openPayload =
                    object
                        [ ( "userUid", string model.userUid ) ]
            in
            ( model, FirebaseCmd "openDb" (encode 0 openPayload) |> sendCmdToFirebaseDb )

        ReadAllData ->
            let
                readAllPayload =
                    object
                        [ ( "storeName", string "data" ) ]
            in
            ( model, FirebaseCmd "readAll" (encode 0 readAllPayload) |> sendCmdToFirebaseDb )

        NewUser (Err error) ->
            let
                log =
                    Debug.log "newUser error" error
            in
            ( model, Cmd.none )

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
            ( { model | data = updatedData }, sendCmdToFirebaseDb (FirebaseCmd "create" (encode 0 createPayload)) )


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
