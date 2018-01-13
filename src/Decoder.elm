module Decoder exposing (decodeData, decodeDbOpened, decodeUser)

import Json.Decode exposing (..)
import Models exposing (..)


decodeDbOpened : Value -> Result String Bool
decodeDbOpened value =
    decodeValue bool value


decodeUser : Value -> Result String UserUid
decodeUser value =
    decodeValue string value


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
