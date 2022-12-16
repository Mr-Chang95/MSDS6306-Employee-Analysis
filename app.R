library(shiny)
library(tidyverse)
library(caret)

employeeData = read_csv("CaseStudy2-data.csv")

employeeData$cleanOverTime = ifelse(employeeData$OverTime=="Yes",1,0)
employeeData$cleanAttrition = ifelse(employeeData$Attrition=="Yes",1,0)

employeeData2 = employeeData

#standardize data
employeeData2$MonthlyIncome=scale(employeeData2$MonthlyIncome)
employeeData2$MonthlyRate=scale(employeeData2$MonthlyRate)
employeeData2$JobSatisfaction=scale(employeeData2$JobSatisfaction)
employeeData2$Age=scale(employeeData2$Age)
employeeData2$EnvironmentSatisfaction=scale(employeeData2$EnvironmentSatisfaction)
employeeData2$DailyRate=scale(employeeData2$DailyRate)
employeeData2$JobLevel=scale(employeeData2$JobLevel)
employeeData2$PercentSalaryHike=scale(employeeData2$PercentSalaryHike)

colors = c("yellow","black","red")


ui = fluidPage(
  
  # app title
  titlePanel("Case Study 2: Attrition Plots Against Predictor Variables"),
  
  # sidebar layout with input/output definitions
  sidebarLayout(
    
    # side bar panel for graphic parameters
    sidebarPanel(
      
      # selectInput for choosing variables
      selectInput(
        inputId = "data",
        label = "Predictor Variables",
        choices = list(
          'MonthlyIncome',
          'JobLevel',
          'OverTime',
          'Age',
          'HourlyRate',
          'JobInvolvement'
        )
      ),
      selectInput(
        inputId = "groups",
        label = "Display by Groups",
        choices = list(
          'Attrition',
          'Gender',
          'BusinessTravel',
          'MaritalStatus'
        )
      ),
      checkboxGroupInput("checkGroup", 
                         label = h3("Prediction Models"), 
                         choices = list("NB Model (Best Model)" = 1, 
                                        "KNN Model" = 2, 
                                        "Linear Regression" = 3),
                         selected = 1),
      
      
      hr(),
      fluidRow(column(12, verbatimTextOutput("NB"))),
 
      
      ## Attrition Count Plot
      plotOutput(
        outputId = "aplot"
      ),
      verbatimTextOutput("nb")
    ),
    
    # main panel for displaying plot
    mainPanel(
      
      
      # histogram output pplot is percentage plot
      plotOutput(
        outputId = "histplot"
      ),
      plotOutput(
        outputId = "pplot"
      ),
      
    )
    
  ),
  
)

# server function for creating app

server  = function(input,output){
  
  # renderPlot function is used to map the histogram inputs to main panel outputs
  # this plot is "reactive," i.e. changes when inputs (e.g. bins) are altered
 
  #Histogram Plot
   output$histplot = renderPlot({
    employeeData |> ggplot(aes_string(x = input$data,fill=input$groups))+
      geom_histogram(stats="identity")+
      xlab(input$data)+
      scale_fill_manual(values=as.vector(colors))+
      ggtitle(paste("Histogram of",
                    input$data,
                    "faceted by",
                    input$groups,
                    sep=" "))
  })
  
  #Percentage Plot
  output$pplot = renderPlot({
    # creating histogram for output
    employeeData |> ggplot(aes_string(x = input$data,fill=input$groups))+
      geom_bar(position="fill")+
      xlab(input$data)+
      scale_y_continuous(labels = scales::percent)+
      scale_fill_manual(values=as.vector(colors))+
      ggtitle(paste("Histogram",
                    input$data,
                    "in Percentages by",
                    input$groups,
                    sep=" "))
  })
  
  #Attrition Count Plot
  output$aplot=renderPlot({
    employeeData %>% ggplot(aes(x=Attrition,fill=Attrition))+ geom_bar()+
      ggtitle("Attrition Count") +
      scale_fill_manual(values=as.vector(colors))+
      xlab("Attrition")+ylab("Count")
  })
  
  #Naive Bayes
  output$nb=renderPrint({

    set.seed(24)
    naive_data=employeeData
    
    model2 = naive_data
    model2$Attrition = as.factor(model2$Attrition)
    
    trainIndices = sample(1:dim(model2)[1],round(.70 * dim(model2)[1]))
    train = model2[trainIndices,]
    test = model2[-trainIndices,]
    
    classifier1 = naiveBayes(model2[,-c(1,4,5,6,8,9,10,11,12,13,14,17,19,21,23,24,28,38)],model2$Attrition)
    
    pred = predict(classifier1,newdata=test)
    CM = confusionMatrix(table(test$Attrition,pred))
    
    CM
  })
  
}

shinyApp(ui = ui, server = server)