library(shiny)

shinyServer(function(input, output) {
   
  output$result <- renderText({
    
    multisub <- function(p, replace, x, ...) {
      result <- x
      for (i in 1:length(p)) {
        result <- gsub(p[i], replace[i], result, ...)
      }
      as.numeric(result)
    }
    
    number <- reactive({
      n1 <- multisub(c("J", "Q", "K", "A"), c(11, 12, 13, 14), input$card1n)
      n2 <- multisub(c("J", "Q", "K", "A"), c(11, 12, 13, 14), input$card2n)
      n3 <- multisub(c("J", "Q", "K", "A"), c(11, 12, 13, 14), input$card3n)
      n4 <- multisub(c("J", "Q", "K", "A"), c(11, 12, 13, 14), input$card4n)
      n5 <- multisub(c("J", "Q", "K", "A"), c(11, 12, 13, 14), input$card5n)
      n <- c(n1, n2, n3, n4, n5)
      return(n)
    })
    
    suit <- reactive({
      s <- c(input$card1s, input$card2s, input$card3s, input$card4s, input$card5s)
      return(s)
    })
    
    comb <- reactive({
      c <- c(paste(number()[1],suit()[1]),
             paste(number()[2],suit()[2]),
             paste(number()[3],suit()[3]),
             paste(number()[4],suit()[4]),
             paste(number()[5],suit()[5]))
      return(c)
    })
    
    if (any(!number() %in% 2:14)) {
      
      stop("Invalid card number(s) present")
      
    } else if (any(!suit() %in% c("H", "D", "S", "C"))) {
      
      stop("Invalid card suit(s) present")
      
    } else if (length(unique(comb())) < 5) {
      
      stop("Duplicate cards present")
      
    }
    
    if (all(suit() == suit()[1])) {
      
      if (all(sort(number()) == c(10, 11, 12, 13, 14))) {
        
        "Royal Flush"
        
      } else if (all(diff(as.numeric(sort(number()))) == 1) | all(sort(number()) == c(2, 3, 4, 5, 14))) {
        
        "Straight Flush"
        
      } else {
        
        "Flush"
        
      }
      
    } else {
      
      agg <- aggregate(data.frame(count = number()), list(value = number()), length)
      
      if (nrow(agg) == 2) {
        
        if (abs(agg[1,2] - agg[2,2]) == 3) {
          
          "Four of a Kind"
          
        } else {
          
          "Full House"
          
        }
        
      } else if (nrow(agg) == 3) {
        
        if (median(agg[,2]) == 1) {
          
          "Three of a Kind"
          
        } else {
          
          "Two Pair"
          
        }
        
      } else if (nrow(agg) == 4) {
        
        "Pair"
        
      } else {
        
        if (all(diff(as.numeric(sort(number()))) == 1) | all(sort(number()) == c(2, 3, 4, 5, 14))) {
          
          "Straight"
          
        } else {
          
          "High Card"
          
        }
      }
    }
  })
  
})