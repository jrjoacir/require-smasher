# RequireSmasher
[![Build Status](https://travis-ci.com/jrjoacir/require-smasher.svg?branch=master)](https://travis-ci.com/jrjoacir/require-smasher)

Read this documentation in [English](README.md).

Este projeto nasceu apenas para resolver um problema: fazer `require` de arquivos em um diretório recursivamente. Porém ele cresceu e aprendeu a resolver outros problemas simples:

- fazer `require` em arquivos `ruby` recursivamente em um diretório e seus subdiretórios, tentando resolver interdependências entre os arquivos (`require_dir`)
- fazer `require` em arquivos `ruby` recursivamente em uma lista de diretórios e seus subdiretórios, tentando resolver interdependências entre os arquivos (`require_dirs`)
- fazer `require` de uma `gem` (`require_gem`)
- fazer `require` de uma lista de `gems` (`require_gems`)
- fazer `require` de um arquivo `ruby` (`require_file`)
- fazer `require` de uma lista de arquivos `ruby` (`require_files`)
- fazer `require` de uma **lista de `gems`**, arquivos `ruby` em uma **lista de diretórios** e seus subdiretórios e uma **lista de arquivos** com apenas **um comando** (`require_all`)

## Instalação

Adicione esta linha no arquivo `Gemfile` de sua aplicação:

```ruby
gem 'require_smasher'
```

E então execute:

    $ bundle

Ou instale-o isoladamente:

    $ gem install require_smasher

## Uso

### Require All

```ruby
require_all 'directory_1', 'directory_2/sub-directory', 'gem_1', 'gem_2', 'directory_3/filename_1', 'filename_2'
```

Este comando fará o `require` de todos os arquivos `ruby` encontrados no diretório `directory_1` e nos seus subdiretórios, todos os arquivos `ruby` no diretório `directory_2/sub-directory` e nos seus subdiretórios, da `gem` `gem_1` e da `gem` `gem_2`, e dos arquivos `directory_3/filename_1.rb` e `filename_2.rb`.

**Observação:** a ordem dos elementos não importa, pois o `Require Smasher` tentará resolver qualquer dependência entre eles.

### Require Dir

```ruby
require_dir 'directory_1'
```
Este comando fará o `require` de todos os arquivos `ruby` encontrados no diretório `directory_1` e em seus subdiretórios.

### Require Dirs

```ruby
require_dirs 'directory_1', 'directory_2/sub-directory'
```
Este comando aceita uma lista de diretórios e fará o `require` de todos os arquivos `ruby` encontrados no diretório `directory_1` e em seus subdiretórios, todos os arquivos `ruby` no diretório `directory_2/sub-directory` e em seus subdiretórios.

### Require Gem

```ruby
require_gem 'gem'
```
Este comando fará o `require` da `gem` informada.

### Require Gems

```ruby
require_gems 'gem_1', 'gem_2'
```
Este comando aceita uma lista de `gems` e fará o `require` das `gems` `gem_1` e `gem_2`.

### Require File

```ruby
require_file 'filename'
```
Este comando fará o `require` do arquivo `filename.rb`. Você não precisa informar a extensão `ruby` do arquivo (**rb**), se você não quiser.

### Require Files

```ruby
require_files 'filename_1', 'directory/filename_2', 'directory/filename_3.rb'
```
Este comando aceita uma lista de arquivos e fará o `require` dos arquivos `filename_1.rb`, `directory/filename_2.rb` e `directory/filename_3.rb`. Você não precisa informar a extensão `ruby` do arquivo (**rb**), se você não quiser.

## Desenvolvimento

### Localmente

Depois de dar `checkout` neste repositório, execute `bin/setup` para instalar as dependências. Então, execute `rake spec` para executar os testes. Você pode também executar `bin/console` para abrir um `prompt` interativo que permitirá você experimentar esta biblioteca (`gem`).

Para instalar esta `gem` dentro de uma máquina local, execute `bundle exec rake install`. Para lançar uma nova versão, atualize o número da versão no arquivo `version.rb`, e então execute `bundle exec rake release`, ele criará uma `tag` do `git` para a versão, dará `push` dos `commits` do `git`, e do arquivo `.gem` para [rubygems.org](https://rubygems.org).

### Utilizando Docker e Docker Compose

Você pode desenvolver esta gem sem qualquer instalação de ferramentas ou bibliotecas usando funcionalidades do [Docker](https://docs.docker.com/install/) e [Docker Compose](https://docs.docker.com/compose/install/). Então, instale o [Docker](https://docs.docker.com/install/), [Docker Compose](https://docs.docker.com/compose/install/) e siga os próximos passos.

1 - Faça o *build* do contêiner docker
```bash
docker-compose build
```

2 - Ingresse na contêiner *app*
```bash
docker-compose run --rm app sh
```

3 - Execute os testes:
Fora do contêiner docker
```bash
docker-compose run --rm app bundle exec rspec
```
Dentro do contêiner docker
```bash
bundle exec rspec
```
4 - Execute o analisador de código
Fora do contêiner docker
```bash
docker-compose run --rm app bundle exec rubocop
```
Dentro do contêiner docker
```bash
bundle exec rubocop
```

Mais informações sobre **parar** (*stop*), **iniciar** (*start*), **reiniciar** (*restart*), **executar** (*run*) contêineres e outros comandos Docker, leia a [Documentação do Docker Compose](https://docs.docker.com/compose/) e a [Documentação do Docker](https://docs.docker.com/).


## Contribuindo

Reportar erros e `pull requests` são bem-vindo no GitHub em https://github.com/jrjoacir/require-smasher. Este projeto tem a intenção de ser seguro, espaço bem-vindo para colaboração, e é esperado que os contribuidores adiram ao código de conduta do [Contributor Covenant](http://contributor-covenant.org).

## Licença

Esta `gem` está disponível como código aberto e está registrada sobres os termos de licença da [MIT License](http://opensource.org/licenses/MIT).

## Código de Conduta

Todos que interagirem com o código fonte do projeto RequireSmasher, `issue trackers`, salas de bate-papo e lista de emails é esperado seguir o [código de conduta](https://github.com/[USERNAME]/require_smasher/blob/master/CODE_OF_CONDUCT.md).
