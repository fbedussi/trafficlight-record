port module OutsideInfo exposing (..)

import Decoder exposing (decodeData, decodeDbOpened, decodeUser)
import Json.Encode exposing (..)
import Models exposing (..)


port infoForOutside : GenericOutsideData -> Cmd msg


port infoForElm : (GenericOutsideData -> msg) -> Sub msg


type InfoForOutside
    = LoginRequest LoginData
    | OpenDb UserUid
    | ReadAllData
    | WriteData Direction PassageData


type InfoForElm
    = UserLoggedIn UserUid
    | DbOpened
    | NewData Data


type alias GenericOutsideData =
    { tag : String
    , data : Json.Encode.Value
    }


sendInfoOutside : InfoForOutside -> Cmd msg
sendInfoOutside info =
    case info of
        LoginRequest loginData ->
            let
                loginPayload =
                    object
                        [ ( "method", string "email" )
                        , ( "email", string loginData.email )
                        , ( "password", string loginData.password )
                        ]
            in
            infoForOutside { tag = "login", data = loginPayload }

        OpenDb userUid ->
            infoForOutside { tag = "openDb", data = string userUid }

        ReadAllData ->
            let
                readAllPayload =
                    object
                        [ ( "storeName", string "data" )
                        ]
            in
            infoForOutside { tag = "readAllData", data = readAllPayload }

        WriteData direction passageData ->
            let
                passageDataEncoded =
                    object
                        [ ( "time", passageData.time |> float )
                        , ( "color", passageData.color |> toString |> String.toLower |> string )
                        ]

                writeDataPayload =
                    object
                        [ ( "direction", direction |> toString |> String.toLower |> string )
                        , ( "passageData", passageDataEncoded )
                        ]
            in
            infoForOutside { tag = "writeData", data = writeDataPayload }


getInfoFromOutside : (InfoForElm -> msg) -> (String -> msg) -> Sub msg
getInfoFromOutside tagger onError =
    infoForElm
        (\outsideInfo ->
            case outsideInfo.tag of
                "loginResult" ->
                    case decodeUser outsideInfo.data of
                        Ok userUid ->
                            tagger <| UserLoggedIn userUid

                        Err e ->
                            onError e

                "dbOpened" ->
                    case decodeDbOpened outsideInfo.data of
                        Ok dbOpened ->
                            tagger <| DbOpened

                        Err e ->
                            onError e

                "allData" ->
                    case decodeData outsideInfo.data of
                        Ok data ->
                            tagger <| NewData data

                        Err e ->
                            onError e

                _ ->
                    onError <| "Unexpected info from outside: " ++ toString outsideInfo
        )


switchInfoForElm : InfoForElm -> Model -> ( Model, Cmd msg )
switchInfoForElm infoForElm model =
    case infoForElm of
        UserLoggedIn userUid ->
            let
                loginData =
                    LoginData
                        model.loginData.email
                        ""
                        True
            in
            ( Model
                Home
                model.data
                loginData
                ""
            , OpenDb userUid |> sendInfoOutside
            )

        DbOpened ->
            ( model, sendInfoOutside ReadAllData )

        NewData data ->
            ( { model | data = data }, Cmd.none )
