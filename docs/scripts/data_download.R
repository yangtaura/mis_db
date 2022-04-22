
url <- "https://odk-central.swisstph.ch/v1
/projects/17/forms/prev_v1.svc"

form_id <- "prev_v1"
un <- "myo.minnoo@swisstph.ch"
pw <- "malcon@2022!"

ruODK::ru_setup(
  svc = url,
  fid = form_id,
  un = un,
  pw = pw,
  verbose = TRUE,
  tz = "Australia/Perth"
)

temp <- tempdir()

se <- ruODK::submission_export(
  local_dir = temp,
  overwrite = TRUE,
  verbose = TRUE
)

#
utils::unzip(zipfile = se, exdir = temp)

file_dir <- paste0(temp, "/prev_v1.csv")
prev <- read.csv(file_dir, header = TRUE)

library(tidyverse)

clean <- prev %>% 
  select(SubmissionDate,date,int_name,p_id) %>% 
  mutate(SubmissionDate = lubridate::ymd_hms(SubmissionDate),
         SubmissionDate = as.Date(SubmissionDate),
         date = lubridate::ymd(date),
         date = as.Date(date),
         p_id = case_when(
           p_id == 3 ~ "Central",
           p_id == 5 ~ "Milne Bay",
           p_id == 6 ~ "Oro",
           TRUE ~ "Other"
         ))
  