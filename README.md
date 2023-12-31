## School Mobile


### Sobre o Projeto

Aplicação criada para simular um sistema de gerenciamento de uma escola, com operações de CRUD para Cursos e Estudantes, além de poder relacioná-los através de Matrículas.

Os dados do sistema são gerenciados por uma API, nesse [link](https://github.com/guilhermeqmaia/school_erp_api), que é indispensável para que seja possível rodar o app com sucesso.

Se quiser ver um vídeo de exibição do projeto, clique [aqui](https://www.loom.com/share/bedda397356046caaaf9c9da2bba7540?sid=32ac272a-8132-4f1a-b9b0-96383403aaf9)

### Libs e Utilização no Sistema

- dio (Requisições HTTP)
- flutter_bloc (gerenciamento de estados)
- flutter_modular (organização da arquitetura da aplicação, gerenciamento de rotas, injeção de dependências e navegação)
- intl (internacionalização de datas)
- mask_text_input_formatter (utilizado para gerar uma máscara em Inputs do tipo de data)
- json_annotation (usado para geração de arquivos para consumo de modelos de APIs)
- build_runner (usado para executar geração de arquivos)
- json_serializable (utilizado em conjunto com as duas anteriores para gerar métodos de mapeamento de resposta das APIs)
- mocktail (utilizado para geração de classe de mock para implementação de testes unitários)

### Setup para rodar

Basta ter a API rodando na máquina e adicionar o IPV4 do computador no arquivo config.dart para que ele consiga se conectar a API.