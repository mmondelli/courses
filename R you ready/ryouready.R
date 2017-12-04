## Pacotes  ##########
install.packages('plyr', 'magittr')       # Para instalar pacotes
library(plyr)                  # Para carregar pacotes
packageVersion("plyr")         # Verificar versão
sessionInfo()                  # Infos sobre a sessão atual do R (inclusive pacotes carregados)

## Help ##################################################
help.search("mean")
??mean
?mean

# ctrl+l: limpa os comandos do console

## Diretório de trabalho ##########
getwd() # Mostra o diretório atual
setwd('~/Dropbox/Cursos/R you ready/') # Muda de diretório

## Input ###########
5 + 2
sqrt(121)

x <- 5 + 2
print(x)
x

y <- sqrt(121)
y

## Tipos de Dados ###########

# Numérico
valor <- 60.5
typeof(valor)

# Caracteres
string <- "Olá, mundo!"
typeof(string)

# Lógicos
logico <- 2 < 6
typeof(logico)

# Números complexos
complexo <- 2 + 3i
typeof(complexo)

## Sequências, repetições e dados aleatórios ####

# Repetições
rep(1:5, times = 2)
rep(c(1, 2, 3), times = 3)

## Sua vez: Criar uma repetição de dois números
## O primeiro deve ser repetido 5 vezes, o segundo 3 vezes
rep(c(4, 2), times = c(5,3))

# Sequências
seq(from = 1, to = 3)
seq(1,3)
seq(1,10, by = 0.5)
seq(10, -3, length.out = 9)

# Dados aleatórios
set.seed(1)
x <- rnorm(100)
y <- runif(100)

set.seed(5)
sample(LETTERS[1:3], 12, replace=TRUE)

## Objetos no R ##########
# 1. Vetores
my.vector <- c(1,6,7,3,8,0)

# 2. Matrizes
my.matrix <- matrix(1:12, nrow=4, ncol=3)

# 4. Dataframes
my.df <- data.frame(nome = c("Maria","João","José","Gabriela"), 
                          nota = c(10, 9, 7, 9))

# 5. Listas
my.list <- list(10, "ABC", TRUE, 1 + 2)

# 6. Funções
jogar.moeda <- function(x, n){
  sample(x, n, replace=T)
} 
moeda <- c("Cara", "Coroa")
jogar.moeda(moeda, 10)

## Algumas operações com objetos ##########
min(my.vector) # Retorna menor valor do objeto de entrada
min(my.df)
?min
max(my.vector)

str(my.df); str(my.list)            # Retorna a estrutura de um objeto de entrada

summary(my.df); summary(my.vector)  # Retorna um resumo do objeto (média, min, max, etc)

length(my.vector)                   # Retorna o tamanho de um vetor

dim(my.matrix); dim(my.df)          # Linhas e colunas da matriz ou dataframe

class(my.vector); class(my.df)      # Retorna a classe de um objeto

my.vectorChar <- as.character(my.vector); my.vectorChar
class(my.vectorChar)

# Acessando elementos dos objetos (Subsetting)
my.vector[3]      # Elemento 3 do vetor
my.vector[c(2,5)] # Elementos 2 e 5 do vetor

my.df[,2]         # Coluna dois do dataframe, todas as linhas
my.df[1,2]        # Linha 1, coluna 2
my.df[1,]         # Linha 1
my.df[c(1,4), ]   # Linhas 1 e 4, todas as colunas

my.matrix[1,]
my.matrix[,4] 
my.matrix[,3]

my.list[1]        # Elemento e seu índice
my.list[[1]]      # Apenas o elemento 

x <- c(1, 2, 3, 4, 5, 6)
y <- c('A','B','C','D','E', 'F')
xy.df <- cbind(x,y); class(xy.df)     # Junta por colunas
xy2.df <- rbind(x,y); class(xy2.df)   # Junta por linhas

my.df
nota2 <- data.frame(nota2 = c(9, 8, 7, 5))
my.df <- cbind(my.df, nota2); my.df
colnames(my.df)
colnames(my.df) <- c('Nome', 'Nota 1', 'Nota 2'); my.df
nrow(my.df); ncol(my.df)

# Missing values (NA)

my.df[1:2,2] <- NA; my.df
is.na(my.df)              # Verifica a existência de NAs
mean(my.df$`Nota 1`)
mean(my.df$`Nota 1`, na.rm = TRUE)

## Estruturas de controle ##########

# IF
x <- 1

if (x * 5 > 40){
  print("É maior!")
} else {
  print("É menor!")
}

# FOR
y <- c(33, 65, 76, 23, 11)

for(i in 1:4){
  print (y[i])
}

## 


## Trabalhando com dados ##########

# Leitura de arquivos

# De um link
chemicalsDisease.df <- read.csv("https://www.crowdflower.com/wp-content/uploads/2016/03/chemicals-and-disease-DFE.csv",
                 sep = ',')
# De um arquivo
chemicalsDisease2.df <- read.csv("./data/chemicals-and-disease.csv")

colnames(chemicalsDisease.df); ncol(chemicalsDisease.df)
colnames(chemicalsDisease2.df); ncol(chemicalsDisease2.df)

#Escrita em arquivos

myChemicalsDisease.df <- chemicalsDisease.df[,c(7, 8, 11, 13)]
head(myChemicalsDisease.df)
write.csv(myChemicalsDisease.df, "./data/myChemicalsDisease.csv")

## Manipulando/Explorando dataframes ##########

## 1. Chemical/Disease dataset ####
# Limpando o dataset anterior
myChemicalsDisease.df$disease_name[1:10]
?gsub
gsub('.*<span class="disease">|</span>.*', "", myChemicalsDisease.df$disease_name[1])
myChemicalsDisease.df$disease_name <- gsub('.*<span class="disease">|</span>.*', "", myChemicalsDisease.df$disease_name)
myChemicalsDisease.df$disease_name[1:10]

# Sua vez: fazer o mesmo para a coluna 'chemical_name'
myChemicalsDisease.df$chemical_name[1:10]
?gsub
gsub('.*<span class="chemical">|</span>.*', "", myChemicalsDisease.df$chemical_name[1])
myChemicalsDisease.df$chemical_name <- gsub('.*<span class="chemical">|</span>.*', "", myChemicalsDisease.df$chemical_name)
myChemicalsDisease.df$chemical_name[1:10]

# Sua vez: Salve o dataset no arquivo novamente (pode ser o mesmo)

# Explorando o dataset 
unique(myChemicalsDisease.df$chemical_name)                             # Remove registros duplicados
uniqueChemicals <- length(unique(myChemicalsDisease.df$chemical_name))  # Total de diferentes 'chemicals'
uniqueDiseases <- length(unique(myChemicalsDisease.df$disease_name))

ddply(myChemicalsDisease.df, .(verify_relationship), nrow)              # Retorna a quantidade de ocorrências 
                                                                        # para cada relação (químico/doença)
myChemicalsDisease.df$verify_relationship == 'yes_direct'               # Lembra do tipo lógico?

yDirect.df <- myChemicalsDisease.df[(myChemicalsDisease.df$verify_relationship 
                       == 'yes_direct'),]                               # Subset do dataframe

# Sua vez: verifique a quantidade de registros (linhas) desse novo data frame


eachChemical.df <- ddply(yDirect.df, .(chemical_name), nrow)  
eachChemical.df <- arrange(eachChemical.df, desc(V1))
top5Chemicals <- eachChemical.df[1:5,]; top5Chemicals

# Sua vez: Verifique o rank das doenças

## 2. Dress/Color dataset ####

dressColor.df <- read.csv('./data/dress_color.csv')

# Explorando o dataframe
summary(dressColor.df)
colnames(dressColor.df); length(colnames(dressColor.df))
nrow(dressColor.df)

unique(dressColor.df$processed_color_combo)
unique(dressColor.df$you)

eachColorCombo.df <- dressColor.df %>% 
             ddply(.(processed_color_combo), nrow) %>%
             arrange(desc(V1))

# Visualizando o resultado
barplot(eachColorCombo.df$V1, 
        main = "Qual a cor do vestido?", 
        xlab = "Cores", 
        ylab = "Quantidade",
        ylim = c(0, max(eachColorCombo.df$V1)+30),
        names.arg=eachColorCombo.df$processed_color_combo)

## Sua vez: visualização da variável 'dressColor.df$you'

## 3. New years resolution dataset ####

resolutions <- read.csv('./data/new-years-resolutions.csv')
unique(resolutions$Resolution_Category)

categoryRegion <- resolutions[,c(5,13)]
head(categoryRegion)

states <- read.csv('./data/US.csv')

# Vamos juntar os dataframes, mas antes:
colnames(categoryRegion) <- c('category', 'state')
states <- states[,c(1,2)]
colnames(states) <- c('state', 'name')

inner <- merge(categoryRegion, states)              # Inner join  
outer <- merge(x = categoryRegion, y = states, 
      by = "state", all = TRUE)                     # Outer join 
left <- merge(x = categoryRegion, y = states, 
      by = "state", all.x = TRUE)                   # Left outer
right <- merge(x = categoryRegion, y = states, 
      by = "state", all.y = TRUE)                   # Right outer
cross <- merge(x = categoryRegion, y = states, 
      by = NULL)                                    # Cross join

# Deletando colunas do dataframe
inner1 <- inner[,-1]   
inner2 <- inner[-1]    
inner[1] <- NULL      # Wojciech Sobala

# Sua vez: agrupe e conte a quantidade de tipos de resoluções por estado 
# Armazene numa variavel 'resolutionsFreq.df'

resolutionsFreq.df <- inner %>% 
  ddply(.(category, name), nrow) %>%
  arrange(desc(V1))

# Outro jeito de agrupar
resolutionsFreq2.df <- data.frame(table(inner))

# Sua vez: qual a diferença entre essas duas formas de calcular a frequencia?

# Calculando a porcentagem de cada resolução

resolutionsPercent <- resolutionsFreq.df %>% 
                      group_by(name) %>% 
                      mutate(percent = 100*V1/sum(V1))

# Gráfico
install.packages('ggplot2')
library(ggplot2)

ggplot(resolutionsPercent, aes(x = name, y = percent)) +
  geom_bar(stat = "identity", aes(fill = category))

ggplot(resolutionsPercent, aes(x = name, y = percent)) +
  geom_bar(stat = "identity", aes(fill = category, width=.8)) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        panel.background = element_rect(colour = "grey", size=0.3),
        legend.title = element_blank()) +
  labs(title = "New years resolution",
    subtitle="United States, 2015",
    y="Percent", 
    x="State")


# Pie Chart

resolutionsPercentCA <- resolutionsPercent[(resolutionsPercent$name == "California"), ]

ggplot(resolutionsPercentCA, 
       aes(x = "", y = percent, fill = category)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start = 0) +
  theme_minimal() +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.border = element_blank(),
    panel.grid = element_blank(),
    axis.ticks = element_blank()
  ) +
  theme_void() 
  
## 44. Temperatura em Teresópolis ####

## 5. Text emotion ####


## 6. Gender classifier

gender.df <- read.csv('./data/gender-classifier.csv')
colnames(gender.df)



