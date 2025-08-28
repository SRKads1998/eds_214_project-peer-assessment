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
  is_in_window <- (Sample_Date > focal_date - (wind_size_weeks / 2) * 7) &
    (Sample_Date < focal_date + (wind_size_weeks / 2) * 7)
  #find the associated concentrations
  window_conc <- conc[is_in_window]
  #calculate the mean
  result <- mean(window_conc, na.rm = TRUE)
  
  return(result)
}

#adding code to create rolling average for CA
nutrients$sample_date <- as.Date(nutrients$sample_date)

ca_ma_once <- moving_average(focal_date = as.Date("1986-05-20"),
                             dates = nutrients$sample_date,
                             conc = nutrients$ca,
                             wind_size_weeks = 9)


nutrients$calc_rolling <- sapply(
  nutrients$sample_date,
  moving_average,
  Sample_Date = nutrients$sample_date,
  conc = nutrients$ca,
  wind_size_weeks = 9
)
