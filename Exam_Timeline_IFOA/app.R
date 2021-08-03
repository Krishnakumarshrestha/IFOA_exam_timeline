library(shiny)
library(timevis) # for timeline
library(shinythemes) # for theam 
library(dplyr) 
# create data frame of event in time line
data <- data.frame(
    id      = 1:10, # sequence of event
    content = c( # event title in sequance
        "CM1A and CP2 paper 1", 
        "CM1B and CP2 paper 2",
        "CP3 and CB2",
        "CS1 A and CP1 paper 1",
        "CS1 B and CP1 paper 2",
        "CS2A, Sp2, Sp4,Sp6",
        "CS2B and SA1-7",
        "CB1",
        "CM2A,SP1,Sp5,SP7",
        "CM2B, SP8 and SP9"),
    start   = c(
        "2021-09-13", "2021-09-14", #event date that occures
        "2021-09-15",
        "2021-09-17","2021-09-20",
        "2021-09-22","2021-09-23",
        "2021-09-24",
        "2021-09-27",
        "2021-09-28"),
    end     = c(NA, NA, NA, NA, NA, NA, NA, NA, NA,NA) # event end date
    ,
    editable=TRUE
) %>%
    mutate(content=paste0(as.Date(start)-Sys.Date()," days left for ","<h3>",content,"</h3>"))

ui <- fluidPage(titlePanel("Exam schedule For IFOA"),
    theme = shinytheme("sandstone"),
    timevisOutput("timeline"),
    h3("Source Code for the application can be found in my github \n
               link:https://github.com/Krishnakumarshrestha/IFOA_exam_timeline")
)

server <- function(input, output, session) {
    output$timeline <- renderTimevis({
        timevis(data)
    })
}

shinyApp(ui = ui, server = server)