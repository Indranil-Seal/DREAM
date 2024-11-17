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

## example usage:
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

