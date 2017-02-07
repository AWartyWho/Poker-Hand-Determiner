library(shiny)

shinyUI(fluidPage(
  
  titlePanel(h1(strong("Poker Hand Determiner"))),
  
  sidebarLayout(
    sidebarPanel(
       p("Card numbers: 2, 3, 4, 5, 6, 7, 8, 9, 10, J, Q, K, A"),
       p("Card suits: H = heart, D = diamond, S = spade, C = club"),
       textInput("card1n", "Card 1 Number", "A"),
       textInput("card1s", "Card 1 Suit (initial)", "H"),
       textInput("card2n", "Card 2 Number", "K"),
       textInput("card2s", "Card 2 Suit (initial)", "H"),
       textInput("card3n", "Card 3 Number", "Q"),
       textInput("card3s", "Card 3 Suit (initial)", "H"),
       textInput("card4n", "Card 4 Number", "J"),
       textInput("card4s", "Card 4 Suit (initial)", "H"),
       textInput("card5n", "Card 5 Number", "10"),
       textInput("card5s", "Card 5 Suit (initial)", "H"),
       submitButton("Submit"),
       width = 6
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       h3(strong("Result: ")),
       h3(textOutput("result")),
       width = 6
    )
  )
))
