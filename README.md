# Video Payer App
Aplicativo de vídeo/shorts desenvolvido em Flutter.

## Visão Geral
O aplicativo foi desenvolvido com **Cursor** (IDE e Agente de IA) e utiliza as tecnologias **ATProto** para que possamos criar a sessão e **Bluesky API** para que possamos utilizar a sessão criada e buscar os vídeos da rede social.

## Modelo de IA
O modelo foi escolhido automaticamente pelo própio agente do Cursor.

## Dependências (pubspec.yaml)
* `video_player`: Player de vídeo.  
* `chewie`: Player de vídeo com mais recursos.  
* `flutter_bloc`: Gerenciamento de estados.  
* `equatable`: Simplifica comparação de objetos.  
* `bluesky`: Para chamadas na API.
* `atproto`: Para criar a sessão.
* `atproto_core`: Para converter a URI do Bluesky.
* `cached_network_image`: Para caching de imagens.

## Requisitos para funcionamento
* Flutter [v3.29.3]
* Dart [v3.7.2]

## Execução do projeto
1. Clone o repositório:
```bash
  git clone https://github.com/mr-kleberlucas/video_player.git
```
2. Navegue até o diretório:
```bash
  cd video_player
```
3. Instale as dependências: 
```bash
  flutter pub get
```
4. Rode o projeto: 
```bash
  flutter run
```

## Estrutura do Projeto
 O projeto utiliza arquitetura **BloC** escolhida pela própria IA.
* `blocs`: Gerenciamento de Estados e Lógica de Negócio.
* `services`: Gerencia dados externos e chamadas na API.
* `screens/widgets`: Gerenciam a visualização.
* `models`: Define a estrutura de dados.

## Nota
Foi utilizado um serviço de e-mail temporário para testes e a sessão é criada a partir desse email, porém se precisarmos utilizar nossa própria sessão do Bluesky, basta informarmos no seguinte arquivo: [lib/services/bluesky_service.dart#L14](https://github.com/mr-kleberlucas/video_player/blob/main/lib/services/bluesky_service.dart#L14)

## Conclusão
O Cursor foi fundamental para modelar o projeto no geral, foi utilizado para o **Front-End**, **Sintaxe de Código** e ainda **Boas Práticas de Programação**.