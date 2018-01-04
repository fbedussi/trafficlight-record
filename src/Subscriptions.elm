module Subscriptions exposing (..)

--import Json.Encode

import Firebase exposing (listenToFirebaseResponse)
import Json.Decode exposing (..)
import Models exposing (..)
import Msgs exposing (Msg)


subscriptions : Model -> Sub Msg
subscriptions model =
    listenToFirebaseResponse (decodeData >> Msgs.NewData)



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
        (field "north" (list colorDecoder))
        (field "south" (list colorDecoder))
        (field "east" (list colorDecoder))
        (field "west" (list colorDecoder))


colorDecoder : Json.Decode.Decoder Color
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
