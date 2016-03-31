# Elm Drip 004.6: Exercise: Ports - Outbound and Inbound

In the last few episodes, we saw how Elm and JavaScript could interact via
ports, both inbound and outbound.

For this exercise, create a new project that has both inbound and outbound
ports:

- On the elm side:
  - Add a text field to reflect a number from the model.
  - Add an inbound port that increments the number when it receives any signal.
  - Add a button.
  - Add an outbound port, and send the number from the model to the port
    whenever the button is clicked.
- On the html side:
  - Add a button that sends a signal to the inbound port when clicked.
  - Each time the Elm outbound port sends a number, add it to an `li` inside of
    a `ul`.
- Note:
  - Since you have both elm and html content at play, you'll want to use
    `Elm.embed` rather than `Elm.fullscreen`.
