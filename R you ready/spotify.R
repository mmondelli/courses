library(devtools)
install_github("tiagomendesdantas/Rspotify")
library(Rspotify)
library(spotifyr)

## Auth Spotify

client_id <- 'b4a7e92fa4324534a3eee07f468fbf8b'
client_secret <-'8dcc12391b684f21b38d1189d1d17003'
client_tokens <- get_tokens()
keys <- spotifyOAuth(client_tokens$access_token,
                     client_id,
                     client_secret)

## Explorando

# Pegar dados da playlist Top Artistas 2017
topArtistas2017 <- getPlaylistSongs("Spotify",
                             "37i9dQZF1DX9dp45EzSeyl",
                             token = keys)
head(topArtistas2017)

# Pegar informação sobre artistas
nomes.artistas <- unique(topArtistas2017$artist)   # Listagem de nome dos artistas da playlist

artistas.df <- c()

# Para cada artista, buscar suas infos e adicionar em um data frame
for(i in 1:length(nomes.artistas)) {
  print(nomes.artistas[i])
  info.artista <- searchArtist(nomes.artistas[i], token = keys)[1,]
  artistas.df <- rbind(artistas.df, info.artista)  
}

head(artistas.df)

# Salvar esse data frame em um arquivo
saveRDS(artistas.df, file = paste('artists_info.Rda'))

# Artista com maior popularidade
artistas.df[which.max(artistas.df$popularity),]

# Artista com maior num. seguidores
artistas.df[which.max(artistas.df$followers),]

## Artistas e Gêneros - separar por linhas
artistas_generos.df <- df_aux <- data.frame(genero=character(),
                                            artista=character())

for(i in 1:nrow(artistas.df)){
  if (artistas.df[i, ]$genres > 0) {
    df_aux <- as.data.frame(unlist(strsplit(artistas.df[i, ]$genres,(","))))
  } else {
    df_aux <- "NA"
  }
  df_aux["artista"] <- artistas.df[i,]$display_name
  artistas_generos.df <- rbind(artistas_generos.df, df_aux)
}

head(artistas_generos.df)
colnames(artistas_generos.df) <- c('genero', 'artista')

# Quantas vezes cada gênero aparece
artistas_generos.df %>% 
  ddply(.(genero), nrow) %>%
  arrange(desc(V1))

# Quantos gêneros cada artista possui
artistas_generos.df %>% 
  ddply(.(artista), nrow) %>%
  arrange(desc(V1))


