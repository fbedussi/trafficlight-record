module Msgs exposing (..)

import Models exposing (Color, Data, Direction, Email, LoginField, Password, UserUid)
import Navigation exposing (Location)
import OutsideInfo exposing (InfoForElm)
import Time exposing (Time)


type Msg
    = OnLocationChange Location
    | ChangeLocation String
    | UpdateLoginData LoginField String
    | Login
    | HandleClick Direction Color
    | RegisterColor Direction Color Time
    | Outside InfoForElm
    | LogErr String
