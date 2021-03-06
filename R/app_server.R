#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # List the first level callModules here
  # Return the requested dataset ----

  # Generate a summary of the dataset ----

  output$summary <- renderText({
    paste("#!/bin/bash", 
          paste("#SBATCH --job-name=", input$jobname, sep = ""),
          paste("#SBATCH --ntasks-per-node=", input$task_per_node, sep = ""),
          paste("#SBATCH --cpus-per-task=", input$cpu_per_taks, sep = ""),
          
          paste("#SBATCH --time", input$jobname),
          paste("#SBATCH --partition=", input$jobname),
          
          
          paste("#SBATCH --mail-type=", input$mail_type),
          paste("#SBATCH --mail-user=", input$mail_user),
          paste("#SBATCH --partition=", input$partition),
          "module load GCC/8.3.0  OpenMPI/3.1.4 R/3.6.2",
          paste("srun R CMD BATCH ", input$file_name, input$report_name),
          
          


    sep = "\n")  
    
  })
  

}
