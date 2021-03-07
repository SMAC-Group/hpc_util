#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # List the first level callModules here
  
  test = "abc"

  output$summary <- renderText({
    
    time = paste(input$time_1, strftime(input$time_2, "%T"), sep = "-")
    paste("#!/bin/bash", 
          paste("#SBATCH --job-name=", input$jobname, sep = ""),
          paste("#SBATCH --ntasks-per-node=", input$task_per_node, sep = ""),
          paste("#SBATCH --cpus-per-task=", input$cpu_per_taks, sep = ""),
          
          paste("#SBATCH --time=", time, sep = ""),
          paste("#SBATCH --partition=", input$jobname, sep = ""),
          
          
          paste("#SBATCH --mail-type=", input$mail_type, sep = ""),
          paste("#SBATCH --mail-user=", input$mail_user, sep = ""),
          paste("#SBATCH --partition=", input$partition, sep = ""),
          "module load GCC/8.3.0  OpenMPI/3.1.4 R/3.6.2",
          paste("srun R CMD BATCH ", input$file_name, input$report_name),
          
          
          
          
          sep = "\n")  
    
  })
  
  
  
  # # Add clipboard buttons
  output$clip <- renderUI({
    
    test_2 = paste("#!/bin/bash", 
          paste("#SBATCH --job-name=", input$jobname, sep = ""),
          paste("#SBATCH --ntasks-per-node=", input$task_per_node, sep = ""),
          
          sep = "\n")  
    rclipButton("clipbtn", "Copy ", clipText = test_2, icon("clipboard"))
  })
  

}
