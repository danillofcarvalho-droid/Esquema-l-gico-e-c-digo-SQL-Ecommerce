# Projeto Banco de Dados E-commerce (MySQL)

Este projeto implementa um esquema relacional em **MySQL** para um cenário de **e-commerce**, com base no modelo lógico proposto no desafio. Foram criadas tabelas com **chaves primárias**, **chaves estrangeiras** e **constraints** para garantir a integridade dos dados, além da inserção de dados de teste e da criação de relacionamentos entre as principais entidades do domínio.

Após a criação do esquema do banco de dados, foram inseridos dados de teste em todas as tabelas para validar os relacionamentos e possibilitar a execução de **consultas SQL mais complexas**. O projeto permite responder perguntas relevantes dentro do contexto de um sistema de comércio eletrônico, como a quantidade de pedidos realizados por cada cliente, a relação entre fornecedores e produtos, os vendedores responsáveis por determinados itens, entre outras análises possíveis a partir dos dados armazenados.

Dessa forma, o trabalho demonstra a aplicação prática de conceitos importantes de **modelagem relacional**, **integridade de dados**, uso de **constraints** e construção de **consultas SQL**, simulando um cenário realista de um banco de dados para e-commerce.

Em relação ao trabalho anterior, foram implementadas as tabelas de **Pagamento** e **Delivery** como refinamentos do modelo conceitual. A tabela **Pagamento** permite que um cliente possua **mais de uma forma de pagamento cadastrada**, enquanto a tabela **Delivery** armazena informações relacionadas à entrega dos pedidos, incluindo **status da entrega, código de rastreio, data estimada de entrega e transportadora responsável**.

Cabe ressaltar que, nesta versão do projeto, todo o desenvolvimento do banco de dados foi realizado utilizando o **MySQL Workbench**, incluindo a modelagem do diagrama relacional e a execução dos scripts SQL.
