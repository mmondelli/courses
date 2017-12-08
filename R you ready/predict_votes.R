## Diretório de trabalho ##########
getwd() # Mostra o diretório atual
setwd('~/Dropbox/Cursos/R you ready/') # Muda de diretório

## Explorando os dados ##########

# Carregando dataset
votes <- read.csv('./data/votes_original.csv')

head(votes)

# Quantidade de democratas e republicanos 
table(votes$Class) 

# Porcentagem de democratas e republicanos
round(prop.table(table(votes$Class)) * 100, digits = 1)

# Resumo do dataset
summary(votes) 

# Bar plot com ggvis
library(ggvis)

votes %>% 
  ggvis(~el.salvador.aid, fill = ~Class) %>% 
  layer_bars()


## Preparando para o modelo de ML ##########

# Substituir y, n e ? por valores numéricos no dataframe votes
votes <- data.frame(lapply(votes, as.character), stringsAsFactors=FALSE)
votes[votes == 'n'] <- 0; votes[votes == 'y'] <- 1; votes[votes == '?'] <- 3

# Criando conjuntos de treino e conjunto de teste
set.seed(1234)

# Escolher aleatoriamente os registros para cada conjunto
set <- sample(2, nrow(votes), replace=TRUE, prob = c(0.75, 0.25))

# Definir conjunto de treinamento
votes.training <- votes[set==1, 1:16]

head(votes.training)

# Definir conjunto de teste
votes.test <- votes[set==2, 1:16]

head(votes.test)

# Labels do conjunto de treinamento
votes.trainLabels <- votes[set==1,17]

print(votes.trainLabels)

# Labels do conjunto de teste
votes.testLabels <- votes[set==2, 17]

print(votes.testLabels)

## Construir o modelo  ##########
library(class)

?knn

votes.knn <- knn(train = votes.training, 
                 test = votes.test, 
                 cl = votes.trainLabels, 
                 k = 3)

# Verificar resultado do modelo
votes.knn

# Montar um data frame para comparar predição/observado (com os labels que separamos)
votesTestLabels <- data.frame(votes.testLabels)
votes.result <- data.frame(votes.knn, votes.testLabels)
names(votes.result) <- c("Predito", "Observado")
votes.result

# Quantos o modelo acertou?

acertos <- length(which(votes.result$Predito == votes.result$Observado))
erros <- nrow(votesTestLabels) - acertos
acertos * 100 / nrow(votesTestLabels)

## Outro tipo de modelo
install.packages('caret', dependencies = TRUE)
library('caret')

# Redefinir o conjunto de dados

# Definir conjunto de treinamento
votes.training <- votes[set==1, 1:17]

head(votes.training)

# Definir conjunto de teste
votes.test <- votes[set==2, 1:17]

# Random forest
model <- train(Class ~ ., # Class é uma função das demais variáveis que queremos incluir
               data = votes.training, 
               method = 'rf', # Random Forest
               trControl = trainControl(method = 'cv', # Cross-validation
                                        number = 5)) # 5 folds 
model

votes.test$Class <- predict(model, newdata = votes.test)

# Quantos o modelo acertou?

acertos <- length(which(votes.test$Class == votes.result$Observado))
erros <- nrow(votesTestLabels) - acertos
acertos * 100 / nrow(votesTestLabels)

