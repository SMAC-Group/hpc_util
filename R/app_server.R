#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # List the first level callModules here
  


  output$summary <- renderText({
    
    # set time
    time_hour_min = paste(input$time_hour, input$time_min, "00" , sep= ":")
    time = paste(input$time_day, time_hour_min, sep = "-")
    
    # partitions
    all_partitions_2 = paste(trimws(as.vector(input$partition_2)), collapse = ",")
    
    # mail type
    all_mail_type =  paste(input$mail_type_2, collapse = ",")
    
    # load command
    load_cmd = paste("module load GCC/8.3.0  OpenMPI/3.1.4 R/", input$r_version_2, sep = "")

    
    # print bash script
    paste("#!/bin/bash", 
          paste("#SBATCH --job-name=", input$jobname, sep = ""),
          paste("#SBATCH --ntasks-per-node=", input$task_per_node, sep = ""),
          paste("#SBATCH --cpus-per-task=", input$cpu_per_taks, sep = ""),
          
          paste("#SBATCH --time=", time, sep = ""),
          paste("#SBATCH --partition=", all_partitions_2, sep = ""),
          
          paste("#SBATCH --mail-user=", input$mail_user, sep = ""),
          
          paste("#SBATCH --mail-type=", all_mail_type, sep = ""),
         
          load_cmd,
          
          paste("srun R CMD BATCH ", input$file_name, input$report_name),
          
          
          
          
          sep = "\n")  
    
  })
  
  
  
  # # Add clipboard buttons
  output$clip <- renderUI({
    
    
    # set time
    time_hour_min = paste(input$time_hour, input$time_min, "00" , sep= ":")
    time = paste(input$time_day, time_hour_min, sep = "-")
    
    # partitions
    all_partitions_2 = paste(trimws(as.vector(input$partition_2)), collapse = ",")
    
    # mail type
    all_mail_type =  paste(input$mail_type_2, collapse = ",")
    
    # load command
    load_cmd = paste("module load GCC/8.3.0  OpenMPI/3.1.4 R/", input$r_version_2, sep = "")
    
    
    # print bash script
    sh_script = paste("#!/bin/bash", 
          paste("#SBATCH --job-name=", input$jobname, sep = ""),
          paste("#SBATCH --ntasks-per-node=", input$task_per_node, sep = ""),
          paste("#SBATCH --cpus-per-task=", input$cpu_per_taks, sep = ""),
          
          paste("#SBATCH --time=", time, sep = ""),
          paste("#SBATCH --partition=", all_partitions_2, sep = ""),
          
          paste("#SBATCH --mail-user=", input$mail_user, sep = ""),
          
          paste("#SBATCH --mail-type=", all_mail_type, sep = ""),
          
          load_cmd,
          
          paste("srun R CMD BATCH ", input$file_name, input$report_name),
          
          
          
          
          sep = "\n")  
    
    

    rclipButton("clipbtn", "Copy ", clipText = sh_script, icon("clipboard"))
  })
  

}
