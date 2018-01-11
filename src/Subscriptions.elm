module Subscriptions exposing (..)

--import Json.Encode

import Firebase exposing (listenToFirebaseAuthResponse, listenToFirebaseDbResponse)
import Json.Decode exposing (..)
import Models exposing (..)
import Msgs exposing (Msg)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ listenToFirebaseDbResponse (decodeData >> Msgs.NewData)
        , listenToFirebaseAuthResponse (\value -> Msgs.NewUser (decodeUser value))
        ]



-- responseDecoder : Decode.Decoder Data
-- responseDecoder =
--     Decode Data
--         |> required "north" Json.Decode.list colorDecoder
--         |> required "south" Json.Decode.list colorDecoder
--         |> required "east" Json.Decode.list colorDecoder
--         |> required "west" Json.Decode.list colorDecoder


decodeData : Value -> Result String Data
decodeData value =
    decodeValue dataDecoder value


dataDecoder : Decoder Data
dataDecoder =
    map4 Data
        (field "north" decodeDirection)
        (field "south" decodeDirection)
        (field "east" decodeDirection)
        (field "west" decodeDirection)


decodeDirection : Decoder (List PassageData)
decodeDirection =
    keyValuePairs passageDataDecoder
        |> map (List.map Tuple.second)


passageDataDecoder : Decoder PassageData
passageDataDecoder =
    map2 PassageData
        (field "time" Json.Decode.float)
        (field "color" colorDecoder)


colorDecoder : Decoder Color
colorDecoder =
    string
        |> andThen
            (\str ->
                case str of
                    "red" ->
                        Json.Decode.succeed Red

                    "green" ->
                        Json.Decode.succeed Green

                    somethingElse ->
                        Json.Decode.fail <| "Unknown color: " ++ somethingElse
            )



-- encodeData : Data -> Json.Encode.Value
-- encodeData record =
--     Json.Encode.object
--         [ ( "north", Json.Encode.list <| List.map Json.Encode.string <| record.north )
--         , ( "south", Json.Encode.list <| List.map Json.Encode.string <| record.south )
--         , ( "east", Json.Encode.list <| List.map Json.Encode.string <| record.east )
--         , ( "west", Json.Encode.list <| List.map Json.Encode.string <| record.west )
--         ]


decodeUser : Value -> Result String UserUid
decodeUser value =
    decodeValue string value
