module ElmTests exposing (..)

--import Fuzz exposing (Fuzzer, int, list, string)

import Expect exposing (Expectation)
import Helpers exposing (..)
import Test exposing (..)


suite : Test
suite =
    describe "Example test"
        [ test "Example helper" <|
            \() ->
                Helpers.example ()
                    |> Expect.equal True
        ]
