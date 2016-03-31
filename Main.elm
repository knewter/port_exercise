import Html exposing (..)
import StartApp
import Html.Events exposing (onClick)
import Effects exposing (Effects)
import Task exposing (Task)

type alias Model = Int
type Action = Increment | Send | NoOp


initialModel : Model
initialModel =
  0


update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    Increment ->
      ( model + 1
      , Effects.none
      )
    Send ->
      ( model
      , sendToOutboundMailbox model
      )
    NoOp ->
      ( model, Effects.none )


view : Signal.Address Action -> Model -> Html
view address model =
  div []
  [ div [] [text (toString model)]
  , button [ onClick address Send ] [ text "Send" ]
  ]


app =
  StartApp.start
    { init = (initialModel, Effects.none)
    , update = update
    , view = view
    , inputs =
      [ Signal.map mapIncrement increment
      ]
    }


main =
  app.html


mapIncrement : () -> Action
mapIncrement _ =
  Increment


outboundMailbox : Signal.Mailbox Int
outboundMailbox =
  Signal.mailbox 0


sendToOutboundMailbox : Int -> Effects Action
sendToOutboundMailbox count =
  Signal.send outboundMailbox.address count
  |> Effects.task
  |> Effects.map (always NoOp)


-- INPUT PORTS
port increment : Signal ()

-- OUTPUT PORTS
port outbound : Signal Int
port outbound =
  outboundMailbox.signal


port tasks : Signal (Task.Task Effects.Never ())
port tasks =
  app.tasks
