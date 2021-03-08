#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import rclipboard
#' @import shinythemes
#' @import shinyWidgets
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
          textInput(inputId =  "jobname", label = "Job name", value = "my_job",
                    width = NULL, placeholder = NULL),
          
          # Input: task per node
          numericInput("task_per_node", "Task per node:", 1, min = 1, max = 8),
          
          # cpu
          numericInput("cpu_per_taks", "CPU per task:", 1, min = 1, max = 8),
          
          h4("Computing time"),

          div(style="display: inline-block;vertical-align:top; width: 70px;",   numericInput(inputId = "time_day", label = "Day", max = 3, min =0,step = 1, value = 0)),
          div(style="display: inline-block;vertical-align:top; width: 70px;",   numericInput(inputId = "time_hour", label = "Hours", max = 23, min =0,step = 2, value = 2)),
          div(style="display: inline-block;vertical-align:top; width: 70px;",  numericInput(inputId = "time_min", label = "Minutes", max = 59, min =0,step = 10, value = 0)),
          
         
          # partition

          pickerInput("partition_2","Partitions", 
                      choices=c("debug-cpu" ,"public-cpu","public-bigmem","shared-cpu","shared-bigmem"), selected = c("debug-cpu" ,"public-cpu","public-bigmem","shared-cpu","shared-bigmem"), 
                      options = list(`actions-box` = TRUE),
                      multiple = T),
        
          
          # mail user
          textInput(inputId =  "mail_user", label = "Email", value = "name.surname@unige.ch",
                    width = NULL, placeholder = NULL),
          

          pickerInput("mail_type_2","Notification of job events", 
                      choices=c("BEGIN", "END", "FAIL", "REQUEUE",  "ALL"), selected = "ALL", 
                      options = list(`actions-box` = TRUE),
                      multiple = T),
          
          pickerInput("r_version_2","R version", 
                      choices=c("3.6.0", "3.6.2", "4.0.0"), selected = "4.0.0", 
                      options = list(`actions-box` = TRUE),
                      multiple = F),

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

