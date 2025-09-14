# Rick and Morty
### (universo_rick_v2)

Aplicativo Flutter para explorar personagens do universo Rick and Morty. O projeto foi desenvolvido com foco em modularidade, escalabilidade e boas práticas de arquitetura, utilizando Flutter Modular para rotas e injeção de dependências, MobX para gerenciamento de estado reativo e separação clara de camadas.

## 🏗️ Arquitetura
O projeto segue o padrão Clean Architecture, separando responsabilidades em três camadas principais:
- Data: Implementa datasources e repositórios, responsáveis por buscar dados de APIs externas e persistência local.
- Domain: Contém entidades e usecases, representando as regras de negócio e abstrações do sistema.
- Presentation: Inclui stores (MobX), páginas e widgets, responsáveis pela interface e interação com o usuário.

### Justificativa:
Essa separação facilita testes, manutenção e evolução do projeto, permitindo que cada camada evolua independentemente.

## 🔌 Injeção de Dependências
Utiliza o Flutter Modular para registrar e gerenciar dependências como singletons.
Exemplo de registro:

i.addSingleton`<ICharacterRemoteDatasource>`(CharacterRemoteDatasourceImpl.new);

Como funciona:
- Todas as dependências (datasources, repositórios, usecases, stores) são registradas no AppModule.
- O acesso é feito via Modular.get`<Tipo>`(), garantindo instância única e desacoplamento entre as classes.

### Justificativa:
A injeção de dependência via Modular facilita o reaproveitamento de instâncias, reduz acoplamento e torna o código mais testável e escalável.

## 🚦 Gerenciamento de Rotas
As rotas são declaradas no AppModule, permitindo navegação dinâmica e passagem de dados entre telas:

r.child('/', child: (_) => const SplashPage());
r.child('/characters/', child: (_) => const CharacterListPage());
r.child('/characters/details', child: (_) => CharacterDetailsPage(character: r.args.data));

### Justificativa:
O uso do Modular para rotas centraliza o controle de navegação, facilita manutenção e permite passagem segura de argumentos entre páginas.

## 🔄 Gerência de Estado
O estado da aplicação é gerenciado com MobX:
- O CharacterStore é responsável por buscar e armazenar a lista de personagens.
- O widget Observer atualiza automaticamente a interface quando o estado muda.

### Justificativa:
MobX oferece reatividade simples e eficiente, mantendo a UI sincronizada com o estado e reduzindo boilerplate.

## 📚 Relação entre Classes
- CharacterListPage: Página principal, exibe lista de personagens usando o CharacterStore.
- CharacterStore: Gerencia estado da lista, busca personagens via usecase.
- GetAllCharacters: Usecase que orquestra a busca de personagens no repositório.
- CharacterRepositoryImpl: Implementação do repositório, acessa o datasource remoto.
- CharacterRemoteDatasourceImpl: Datasource que faz requisições HTTP usando Dio.
- Injeção de dependência: Todas as classes acima são registradas como singleton no Modular e acessadas via Modular.get.

## 🚀 Instruções de Uso
Pré-requisitos
- Flutter instalado
- CocoaPods instalado (sudo gem install cocoapods) para iOS
- Xcode (para rodar em simulador/dispositivo iOS)
### Instalação
1. Clone o repositório

- Comando: git clone https://github.com/claudiovianna/rickandmorty
- Comando: cd universo_rick_v2

2. Instale as dependências

- Comando: flutter pub get

3. Configure os assets
Certifique-se que as imagens usadas estão declaradas no pubspec.yaml.

4. Instale os pods (iOS)

- Comando: cd ios
- Comando: pod install

### Execução
- Para Android (comando): flutter run
- Para iOS (escolha o device com flutter devices)(comando): flutter run -d `<device_id>`

## 📝 Observações Finais
- O projeto foi desenvolvido com foco em boas práticas, modularidade e reatividade.
- O uso do Flutter Modular e MobX garante escalabilidade e facilidade de manutenção.
- A arquitetura desacoplada permite evolução e testes facilitado.
