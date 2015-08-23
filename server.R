library(shiny)
library(caret)
library(lattice)
library(klaR)
library(kernlab)
library(nnet)
library(randomForest)
library(e1071)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  output$featuresPlot <- renderPlot({
    x = iris[,input$x_feature]
    y = iris[,input$y_feature]
    
    qplot(x, y, color=iris$Species, xlab=input$x_feature, ylab=input$y_feature) +
      ggtitle("Flower classification") + 
      theme(plot.title = element_text(lineheight=.8, size=20, face="bold"), 
            legend.title = element_text(size = 16, face = "bold"))+
      guides(color=guide_legend(title="Flower Species"))
  })
  
  train_control <- trainControl(method="cv", number=5)
  # train the model 
  nb_model = train(Species~., data=iris, trControl=train_control, method="nb")
  rf_model = train(Species~., data=iris, trControl=train_control, method="rf")
  svm_model = train(Species~., data=iris, trControl=train_control, method="svmLinear")
  log_model = train(Species~., data=iris, trControl=train_control, method="multinom")
  
  
  output$confusion <- renderPrint({
    classifier = input$classifier
    if (classifier == 1){
      model = log_model
    } else if (classifier ==2 ){
      model = rf_model
    } else if (classifier ==3 ){
      model = svm_model
    } else {
      model = nb_model
    }
    
    # make predictions
    predictions <- predict(model, iris[,1:4])
    # summarize results
    confusionMatrix(predictions, iris$Species)
  })
  
  
  
  
})