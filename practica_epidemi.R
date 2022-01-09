library(tidyverse)
library(dplyr)

# Packages available from CRAN
##############################
pacman::p_load(
  
  # learning R
  ############
  learnr,   # interactive tutorials in RStudio Tutorial pane
  swirl,    # interactive tutorials in R console
  
  # project and file management
  #############################
  here,     # file paths relative to R project root folder
  rio,      # import/export of many types of data
  openxlsx, # import/export of multi-sheet Excel workbooks 
  
  # package install and management
  ################################
  pacman,   # package install/load
  renv,     # managing versions of packages when working in collaborative groups
  remotes,  # install from github
  
  # General data management
  #########################
  tidyverse,    # includes many packages for tidy data wrangling and presentation
  #dplyr,      # data management
  #tidyr,      # data management
  #ggplot2,    # data visualization
  #stringr,    # work with strings and characters
  #forcats,    # work with factors 
  #lubridate,  # work with dates
  #purrr       # iteration and working with lists
  linelist,     # cleaning linelists
  naniar,       # assessing missing data
  
  # statistics  
  ############
  janitor,      # tables and data cleaning
  gtsummary,    # making descriptive and statistical tables
  rstatix,      # quickly run statistical tests and summaries
  broom,        # tidy up results from regressions
  lmtest,       # likelihood-ratio tests
  easystats,
  # parameters, # alternative to tidy up results from regressions
  # see,        # alternative to visualise forest plots 
  
  # epidemic modeling
  ###################
  epicontacts,  # Analysing transmission networks
  EpiNow2,      # Rt estimation
  EpiEstim,     # Rt estimation
  projections,  # Incidence projections
  incidence2,   # Make epicurves and handle incidence data
  i2extras,     # Extra functions for the incidence2 package
  epitrix,      # Useful epi functions
  distcrete,    # Discrete delay distributions
  
  
  # plots - general
  #################
  #ggplot2,         # included in tidyverse
  cowplot,          # combining plots  
  # patchwork,      # combining plots (alternative)     
  RColorBrewer,     # color scales
  ggnewscale,       # to add additional layers of color schemes
  
  
  # plots - specific types
  ########################
  DiagrammeR,       # diagrams using DOT language
  incidence2,       # epidemic curves
  gghighlight,      # highlight a subset
  ggrepel,          # smart labels
  plotly,           # interactive graphics
  gganimate,        # animated graphics 
  
  
  # gis
  ######
  sf,               # to manage spatial data using a Simple Feature format
  tmap,             # to produce simple maps, works for both interactive and static maps
  OpenStreetMap,    # to add OSM basemap in ggplot map
  spdep,            # spatial statistics 
  
  # routine reports
  #################
  rmarkdown,        # produce PDFs, Word Documents, Powerpoints, and HTML files
  reportfactory,    # auto-organization of R Markdown outputs
  officer,          # powerpoints
  
  # dashboards
  ############
  flexdashboard,    # convert an R Markdown script into a dashboard
  shiny,            # interactive web apps
  
  # tables for presentation
  #########################
  knitr,            # R Markdown report generation and html tables
  flextable,        # HTML tables
  #DT,              # HTML tables (alternative)
  #gt,              # HTML tables (alternative)
  #huxtable,        # HTML tables (alternative) 
  
  # phylogenetics
  ###############
  ggtree,           # visualization and annotation of trees
  ape,              # analysis of phylogenetics and evolution
  treeio,            # to visualize phylogenetic files
  skimr
)

#### Importar datos ####

file.choose()
datos<-read.xlsx("D:\\Proyectos\\Epidemiologia\\datos\\linelist_raw.xlsx")

skim(datos) #para obtener una descripción general de todo el marco de datos 

names(datos)

datos <- clean_names(datos)

datos <-datos %>% rename(merged_header_b = x28)

datos %>% select(date_hospital,date_onset, 
                 everything()) #la función everything() re ordena las columnas de modo
                               # que las seleccionadas pasan al principio de la y las
                               # demás manteniendo su mismo orden pasan después de las
                               # seleccionadas

datos %>% select(where(is.character)) # aplica una función where a todas las columnas y 
                                      # selecciona aquellas que son VERDADERAS de acuerdo
                                      # a las características de cada variable
datos %>% select(where(is.numeric))
  
datos %>% select(contains("date")) # columnas que contienen una cadena de caracteres
                                   # similares puestos entre los paréntesis

datos %>% select(starts_with("age")) # coincide con un prefijo especificado en la
                                     # la variable que queremos tener

datos %>% select(ends_with("on")) # coincide con un sufijo especificado
                                  # de la variable pero lo que esta al final

datos %>% select(matches("onset|hosp|fev")) # esta función matches() funciona de manera
                                            # similar a contains() 

dos %>% select(num_range("x01:x03"))

names(datos)

file.choose()

dos<-read.xlsx("D:\\Proyectos\\Epidemiologia\\datos\\linelist_raw.xlsx")
names(dos)  
