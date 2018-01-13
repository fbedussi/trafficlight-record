module Update exposing (update)

import Models exposing (..)
import Msgs exposing (..)
import Navigation exposing (newUrl)
import OutsideInfo exposing (sendInfoOutside, switchInfoForElm)
import Routing exposing (parseLocation)
import Task
import Time exposing (Time)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LogErr err ->
            let
                log =
                    Debug.log "Error: " err
            in
            ( { model | errorMsg = err }, Cmd.none )

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
            ( model, OutsideInfo.LoginRequest model.loginData |> sendInfoOutside )

        Outside infoForElm ->
            switchInfoForElm infoForElm model

        HandleClick direction color ->
            ( model, Task.perform (RegisterColor direction color) Time.now )

        RegisterColor direction color time ->
            let
                newPassageData =
                    PassageData time color

                updatedData =
                    updateData model.data direction newPassageData
            in
            ( { model | data = updatedData }, OutsideInfo.WriteData direction newPassageData |> sendInfoOutside )


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
