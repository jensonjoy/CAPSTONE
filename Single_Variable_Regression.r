library(sqldf)
library(data.table)
library(bit64)

setwd("E:/MSPA/CAPSTONE")
train_clean <- fread("train_CLEAN_DATA.csv")

names(train_clean)
head(train_clean)

# Create a dataset for all products added in the train dataset
sample_set <- sqldf("select * from train_clean where status='Added'" )

dim(sample_set)

#Take 15% of sample for modeling
ind <- sample(2,nrow(sample_set),replace=TRUE,prob=c(0.15,0.85))
train_data <- sample_set[ind==2,]
dim(train_data)

#Split data into Train/Test 70/30
ind <- sample(2,nrow(train_clean), replace=TRUE, prob=c(0.3,0.7))

train <- train_clean[ind==1,]

test <- train_clean[ind==2,]
names(train)
# [1] "fecha_dato"            "ncodpers"              "ind_empleado"          "pais_residencia"       "sexo"                 
# [6] "age"                   "fecha_alta"            "ind_nuevo"             "antiguedad"            "indrel"               
# [11] "ult_fec_cli_1t"        "indrel_1mes"           "tiprel_1mes"           "indresi"               "indext"               
# [16] "conyuemp"              "canal_entrada"         "indfall"               "nomprov"               "ind_actividad_cliente"
# [21] "renta"                 "segmento"              "month"                 "total.services"        "month.id"             
# [26] "month.next.id"         "feature"               "status"  

# Run multinomial regression for Rent
library(nnet)
reg <- multinom(feature ~ renta ,data=train )
summary(reg)
