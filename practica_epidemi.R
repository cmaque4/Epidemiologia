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

datos %>% 
  select(ends_with("on")) %>%  # coincide con un sufijo especificado
  names()                      # de la variable pero lo que esta al final

datos %>% select(matches("onset|hosp|fev")) # esta función matches() funciona de manera
                                            # similar a contains() pero da la opción de
                                            # agregar cadenas separadas por (|) "OR"


### Quitar columnas

datos %>%  
  select(-c(date_onset, fever:vomit)) %>% 
  names()

### Selección 
datos %>% 
  select(case_id, contains("age")) %>% 
  names()

# Ahora para seguir vamos a eliminar variables las cuales que no sirven  y vamos a 
# utilizar la función distinct() la cual borrará las filas que sean duplicadas

nuevo <- datos %>% 
  clean_names() %>% 
  select(-c(row_num,merged_header,merged_header_b)) %>% 
  distinct() # Esta función examina cada fila y redice los datos a solo filas únicas
             # elimina filas que son 100% duplicadas

# Aquí vamos a agregar nuevas columnas (variables) 

tres <- nuevo %>% 
  mutate(nueva_var_1 = case_id,
         nueva_var_2 = 7,
         nueva_var_3 = nueva_var_2 + 5,
         nueva_var_4 = str_glue("{hospital} on ({date_onset})"))

# la función transmute() agrega una nueva columna como mutate(), pero también descarta/
# elimina todas las demás columnas que no están entre los paréntesis 

cuatro <-nuevo %>% 
  transmute(nueva_variable =str_glue("{hospital} on ({date_onset})"))

# la función group_by() agarra de una base de datos los datos cualitativos y los agrupa
# de modo que las operaciones que se hagan con summarise() se harán para cada uno de los
# grupos que definamos


nuevo %>% group_by(hospital) %>% summarise(cantidad = n())

iris %>% 
  group_by(Species) %>% 
  summarise(media1=mean(Sepal.Width),media2=mean(Petal.Length))




