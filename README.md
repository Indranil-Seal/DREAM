## lib: D.R.E.A.M ~ Data Science, Research, and Engineering Artifacts for Machine Learning
<img src="./images/header.jpg" alt="Header Image" style="width:100%; height:auto;">

DREAM is a comprehensive library designed to support Data Science, Machine Learning, and Artificial Intelligence research. This repository centralizes essential materials, algorithms, and tools, providing a single source for critical resources used in modern data science and AI workflows.

## Overview
DREAM simplifies the process of conducting research and development in data science by aggregating resources commonly needed for machine learning and AI applications.

# Extract File Names and Sizes
This R function scans a folder and its subfolders to identify all Word, PDF, 
and PowerPoint files. It calculates their sizes and the total size they occupy. 
Refer DREAMS/file_hunter.R

## Function Definition

```r
#' Extract File Names and Sizes for Word, PDF, and PowerPoint Files
#'
#' This function scans a given folder and its subfolders to identify all Word, 
#' PDF, and PowerPoint files. It returns their names, sizes in kilobytes, and 
#' the total space they occupy.
#'
#' @param folder_path Character. The path to the folder to scan.
#'
#' @return A list containing:
#' \describe{
#'   \item{files_info}{A data frame with two columns: `file_name` and `size_kb`.}
#'   \item{total_size_kb}{Numeric. The total size of all files in kilobytes (KB).}
#' }
#' 
#' @examples
#' \dontrun{
#' # Example usage:
#' result <- get_files_and_sizes("path/to/your/folder")
#' print(result$files_info)
#' cat("Total Size (KB):", result$total_size_kb, "\n")
#' }
#' 
#' @export
get_files_and_sizes <- function(folder_path) {
  # Supported file extensions
  file_extensions <- c(".doc", ".docx", ".pdf", ".ppt", ".pptx")
  
  if (!dir.exists(folder_path)) {
    stop("Invalid folder path.")
  }
  
  # Initialize storage for results
  files_info <- data.frame(file_name = character(), size_kb = numeric(), stringsAsFactors = FALSE)
  total_size_kb <- 0
  
  # Recursively list all files in the directory
  all_files <- list.files(folder_path, recursive = TRUE, full.names = TRUE)
  
  # Filter files by extension and compute sizes
  for (file_path in all_files) {
    if (any(tolower(tools::file_ext(file_path)) %in% gsub("\\.", "", file_extensions))) {
      file_size_kb <- file.info(file_path)$size / 1024  # Convert size to KB
      files_info <- rbind(files_info, data.frame(file_name = basename(file_path), size_kb = file_size_kb))
      total_size_kb <- total_size_kb + file_size_kb
    }
  }
  
  return(list(files_info = files_info, total_size_kb = total_size_kb))
}

# Example demonstration
main <- function() {
  folder_path <- readline(prompt = "Enter the folder path: ")
  
  # Try to get file information
  tryCatch({
    result <- get_files_and_sizes(folder_path)
    
    if (nrow(result$files_info) == 0) {
      cat("No Word, PDF, or PowerPoint files found in the folder.\n")
    } else {
      cat(sprintf("%-50s %10s\n", "File Name", "Size (KB)"))
      cat(strrep("-", 60), "\n")
      apply(result$files_info, 1, function(row) {
        cat(sprintf("%-50s %10.2f\n", row["file_name"], as.numeric(row["size_kb"])))
      })
      cat(strrep("-", 60), "\n")
      cat(sprintf("%-50s %10.2f\n", "Total Size (KB)", result$total_size_kb))
    }
  }, error = function(e) {
    cat("Error:", e$message, "\n")
  })
}

# Call main function
main()

# You can also use a python version of the above code
This Python script scans a given folder and identifies all Word, PDF, and PowerPoint files. It calculates their individual sizes and provides the total size occupied by these files in the folder.
Refer DREAMS/file_hunter.py

## Script

```python
import os

def get_files_and_sizes(folder_path):
    # List of file extensions to look for
    file_extensions = ['.doc', '.docx', '.pdf', '.ppt', '.pptx']
    total_size = 0
    
    print(f"{'File Name':<50} {'Size (KB)':>10}")
    print("-" * 60)
    
    # Traverse the folder
    for root, _, files in os.walk(folder_path):
        for file in files:
            # Check if file has one of the desired extensions
            if any(file.lower().endswith(ext) for ext in file_extensions):
                file_path = os.path.join(root, file)
                file_size = os.path.getsize(file_path) / 1024  # Convert size to KB
                total_size += file_size
                print(f"{file:<50} {file_size:>10.2f}")
    
    print("-" * 60)
    print(f"{'Total Size (KB)':<50} {total_size:>10.2f}")

# Provide the folder path
folder_path = input("Enter the folder path: ").strip()
if os.path.isdir(folder_path):
    get_files_and_sizes(folder_path)
else:
    print("Invalid folder path.")



## Author & Practitioner 
Indranil Seal
