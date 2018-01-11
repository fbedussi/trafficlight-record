module Msgs exposing (..)

import Models exposing (Color, Data, Direction, Email, LoginField, Password, UserUid)
import Navigation exposing (Location)
import Time exposing (Time)


type Msg
    = OnLocationChange Location
    | ChangeLocation String
    | UpdateLoginData LoginField String
    | Login
    | OpenDb
    | ReadAllData
    | NewUser (Result String UserUid)
    | NewData (Result String Data)
    | HandleClick Direction Color
    | RegisterColor Direction Color Time
