#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # List the first level callModules here
  
  # create sh script
  sh_script = reactive({
    
    # time
    time_hour_min = paste(sprintf('%02d', input$time_hour), sprintf('%02d', input$time_min), "00" , sep= ":")
    time = paste(input$time_day, time_hour_min, sep = "-")
    
    # partitions
    all_partitions_2 = paste(trimws(as.vector(input$partition_2)), collapse = ",")
    
    # mail type
    all_mail_type =  paste(input$mail_type_2, collapse = ",")
    
    # load command
    if(input$r_version_2 == "3.6.0"){
      load_cmd = paste("module load GCC/8.2.0-2.31.1 OpenMPI/3.1.3 R/", input$r_version_2, sep = "")
    }else if(input$r_version_2 == "3.6.2"){
      load_cmd = paste("module load GCC/8.3.0 OpenMPI/3.1.4 R/", input$r_version_2, sep = "")
    }else if(input$r_version_2 == "4.0.0"){
      load_cmd = paste("module load GCC/9.3.0 OpenMPI/4.0.3 R/", input$r_version_2, sep = "")    }  
    
    # mail user
    # show email if different then default
    if(input$mail_user !="name.surname@unige.ch"){
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
      # do not show email if not different then default
    }else if(input$mail_user == "name.surname@unige.ch"){
      # print bash script
      paste("#!/bin/bash", 
            paste("#SBATCH --job-name=", input$jobname, sep = ""),
            paste("#SBATCH --ntasks-per-node=", input$task_per_node, sep = ""),
            paste("#SBATCH --cpus-per-task=", input$cpu_per_taks, sep = ""),
            paste("#SBATCH --time=", time, sep = ""),
            paste("#SBATCH --partition=", all_partitions_2, sep = ""),
            paste("#SBATCH --mail-type=", all_mail_type, sep = ""),
            load_cmd,
            paste("srun R CMD BATCH ", input$file_name, input$report_name),
            sep = "\n")  
    }
    

    
  })
  

  output$summary <- renderText({
    
    sh_script()
    
  })
  
  
  
  # # Add clipboard buttons
  output$clip <- renderUI({
    
    rclipButton("clipbtn", "Copy ", clipText = sh_script(), icon("clipboard"))
    
  })
  

}
