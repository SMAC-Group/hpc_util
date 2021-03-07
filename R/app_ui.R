#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinyTime
#' @import rclipboard
#' @import shinythemes
#' @noRd
app_ui <- function() {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    rclipboardSetup(),
    # List the first level UI elements here
    fluidPage(
      theme = shinytheme("slate"),
      
      # App title ----
      titlePanel("HPC bash deployment scripts"),
      
      # Sidebar layout with a input and output definitions ----
      sidebarLayout(
        
        # Sidebar panel for inputs ----
        sidebarPanel(
          

          # Input: jobname
          textInput(inputId =  "jobname", label = "Enter your job name", value = "my_job",
                    width = NULL, placeholder = NULL),
          
          # Input: task per node
          numericInput("task_per_node", "Task per node:", 1, min = 1, max = 8),
          
          # cpu
          numericInput("cpu_per_taks", "CPU per task:", 1, min = 1, max = 8),

          div(style="display: inline-block;vertical-align:top; width: 70px;",           numericInput(inputId = "time_1", label = "Enter day", max = 3, min =0,step = 1, value = 0)),
          div(style="display: inline-block;vertical-align:top; width: 130px;",          timeInput("time_2", "hour:min", value = strptime("12:34:56", "%T"), minute.steps = 5)),
          
         
          # partition
          # Input: Selector for choosing dataset ----
          selectInput(
            inputId = "partition",
            label = "Choose the possible partitions for your job to be run on:",
            choices = c("debug-cpu" ,"public-cpu","public-bigmem","shared-cpu","shared-bigmem"), selected = "debug-cpu"
          ),
          
          
          #mail type
          textInput(inputId =  "mail_type", label = "Specify the type of emails you want to receive", value = "ALL",
                    width = NULL, placeholder = NULL),
          
          # mail user
          textInput(inputId =  "mail_user", label = "Enter your Email", value = "name.surname@unige.ch",
                    width = NULL, placeholder = NULL),
          
          # file name
          textInput(inputId =  "file_name", label = "Enter the name of the R script", value = "my_R_script.R",
                    width = NULL, placeholder = NULL),
          
          # report name
          textInput(inputId =  "report_name", label = "Enter the name of .Rout report", value = "my_report.Rout",
                    width = NULL, placeholder = NULL),
          
         

        ),
        
        # Main panel for displaying outputs ----
        mainPanel(
          
          # Output: Verbatim text for data summary ----
          verbatimTextOutput("summary"),
          # UI ouputs for the copy-to-clipboard buttons
          uiOutput("clip"),

        )
      )
    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'golembash'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

