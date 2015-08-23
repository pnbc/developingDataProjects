library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  

  # Application title
  titlePanel("Explore Iris dataset"),
  
  
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      h2("Explore Features"),
      
      h5("The following section allows you to explore the connection between features in iris dataset and the output label (species column)"),
      h5("Choose features for x and y axis and see the plot of the flowers with colors of points representing classes of species"),
      
      # For x and y variables, show all columns apart from the class (last column)
      selectInput("x_feature", label = h3("Select x"), 
                         choices = colnames(iris[, -ncol(iris)]), selected = "Sepal.Length"),
      
      selectInput("y_feature", label = h3("Select y"), 
                  choices = colnames(iris[,-ncol(iris)]), selected = "Sepal.Width")
      
    ),
    
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("featuresPlot")
    )
  ),
  sidebarLayout(
    sidebarPanel(
     h2("Classifiers"), 
      
     h5("This section allows you to try different classifiers on iris dataset. All classifiers are trained with 5 fold cross validation and right panel returns confusion matrix for a selected classifier"),
      h5("Choose classifier you want to fit"),
      radioButtons("classifier", label = h3("Available models"),
                   choices = list("Multinomial logistic regression" = 1, "Random forest" = 2,
                                  "Linear kernel SVM" = 3, "Naive Bayes"=4),selected = 1)
      
    ),
    
    
    # Show a plot of the generated distribution
    mainPanel(
      verbatimTextOutput('confusion')
    )
  )
))