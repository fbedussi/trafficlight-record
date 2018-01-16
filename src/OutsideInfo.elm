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


getInfoFromOutside : (Result String InfoForElm -> msg) -> Sub msg
getInfoFromOutside tagger =
    infoForElm
        (\outsideInfo ->
            case outsideInfo.tag of
                "loginResult" ->
                    case decodeUser outsideInfo.data of
                        Ok userUid ->
                            tagger <| Ok <| UserLoggedIn userUid

                        Err e ->
                            tagger <| Err "Bad email or password"

                "dbOpened" ->
                    case decodeDbOpened outsideInfo.data of
                        Ok dbOpened ->
                            tagger <| Ok <| DbOpened

                        Err e ->
                            tagger <| Err "Error opening DB"

                "allData" ->
                    case decodeData outsideInfo.data of
                        Ok data ->
                            tagger <| Ok <| NewData data

                        Err e ->
                            tagger <| Err "Error retriving data"

                _ ->
                    tagger <| Err <| "Unkonw error communicating with backend"
        )


switchInfoForElm : Result String InfoForElm -> Model -> ( Model, Cmd msg )
switchInfoForElm infoForElm model =
    case infoForElm of
        Ok (UserLoggedIn userUid) ->
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

        Ok DbOpened ->
            ( model, sendInfoOutside ReadAllData )

        Ok (NewData data) ->
            ( { model | data = data }, Cmd.none )

        Err message ->
            ( { model | errorMsg = message }, Cmd.none )
