#Creating Rolling Average Function

#' 9 Week Rolling Mean Function
#'
#' @param focal_date 
#' @param Sample_Date 
#' @param conc 
#' @param wind_size_weeks 
#'
#' @returns
#' @export
#'
#' @examples
moving_average <- function(focal_date, Sample_Date, conc, wind_size_weeks) {
  #Which dates are in the window
  is_in_window <- (dates > focal_date - (wind_size_weeks / 2) * 7) &
    (dates < focal_date + (wind_size_weeks / 2) * 7)
  #find the associated concentrations
  window_conc <- conc[is_in_window]
  #calculate the mean
  result <- mean(window_conc)
  
  return(result)
}

