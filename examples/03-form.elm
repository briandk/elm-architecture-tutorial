module Main exposing (Model, Msg(..), init, main, passwordFieldsAgree, passwordIsLongEnough, update, validateInputs, validationStatus, view, viewInput)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    }


init : Model
init =
    Model "" "" ""



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ viewInput "text" "Name" model.name Name
        , viewInput "password" "Password" model.password Password
        , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
        , validationStatus model
        ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    input [ type_ t, placeholder p, value v, onInput toMsg ] []


passwordIsLongEnough : String -> Bool
passwordIsLongEnough pw =
    String.length pw > 8


passwordFieldsAgree : String -> String -> Bool
passwordFieldsAgree pw pw_again =
    String.contains pw pw_again && String.contains pw_again pw


validateInputs : Model -> Bool
validateInputs model =
    passwordFieldsAgree model.password model.passwordAgain
        && passwordIsLongEnough model.password


validationStatus : Model -> Html msg
validationStatus model =
    if (passwordFieldsAgree model.password model.passwordAgain) then
      if passwordIsLongEnough
        div [ style "color" "red" ] [ text "Passwords do not match!" ]

    else
        div [] []



-- if (not (passwordIsLongEnough model.password)) then
--       div [ style "color" "red" ] [ text "Your password must meet the minimum length requirement" ]
--       else div [] []
-- if passwordFieldsAgree model.password model.passwordAgain and passwordIsLongEnough model.password
--     div [ style "color" "green" ] [ text "OK" ]
--     else div []
