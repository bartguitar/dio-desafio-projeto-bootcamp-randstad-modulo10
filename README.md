🚀 Desafio de Projeto: Integrando e Transformando Dados com Power BI

📒 Visão Geral do Projeto

Este projeto foi desenvolvido como parte da Formação Power BI Analyst e simula um cenário real de ETL (Extract, Transform, Load). O objetivo central foi integrar o Power BI a uma base de dados (Company) hospedada no MySQL na Azure e aplicar um conjunto complexo de transformações no Power Query para garantir a qualidade, integridade e a estrutura ideal dos dados para a análise e futura modelagem dimensional.

💻 Tecnologias e Ferramentas

Categoria

Ferramenta

Uso no Projeto

Cloud e Banco de Dados

Azure MySQL

Hospedagem da base de dados transacional.

Integração e Transformação

Microsoft Power BI (Power Query)

Conexão, limpeza, enriquecimento, mesclagem e agrupamento de dados.

Conexão

MySQL Workbench

Utilizado para acesso e manipulação inicial do banco de dados na Azure.

✅ Etapas Executadas

O fluxo de trabalho foi dividido em três macro-etapas, desde o setup do ambiente até as transformações finais.

1. Configuração e Conexão (Extração)

Criação da instância do MySQL no serviço Azure.

Configuração das regras de Firewall na Azure para acesso seguro.

Criação do banco de dados Company e população com o script de dados.

Conexão e Integração do Power BI com o MySQL na Azure.

2. Transformação de Dados (Power Query)

Todas as transformações listadas foram aplicadas no Editor Avançado do Power Query para adequar os dados.

2.1 Limpeza e Padronização

Ajuste de tipos de dados e cabeçalhos.

Conversão de valores monetários para o tipo Double Preciso.

Análise e tratamento de valores nulos:

Verificação de nulos em Super_ssn (Gerentes).

Preenchimento de lacunas em departamentos sem gerente com dados supostos.

Verificação da consistência do número de horas dos projetos.

Separação de colunas complexas (se aplicável).

Eliminação das colunas desnecessárias para o relatório.

2.2 Mesclagem de Consultas e Enriquecimento

Mescla 1 (Colaborador e Departamento): Junção da tabela employee com departament para associar o nome do departamento a cada colaborador. (Tipo de junção: Left Outer, baseada em employee).

Junção de Gerentes: Realização da junção dos colaboradores com seus respectivos nomes de gerentes (auto-junção).

Nota: A junção de gerentes foi implementada via Consulta SQL

Mesclagem de Nomes: Mesclagem das colunas Nome e Sobrenome em uma única coluna de nome completo.

Mesclagem para Chave Dimensional: Mesclagem das colunas de nomes de departamentos e localização, criando uma chave composta única (Departamento-Local) para facilitar a criação do Modelo Estrela.

2.3 Agrupamento Final

Agrupamento: Agrupamento dos dados para calcular o total de colaboradores por gerente, preparando uma nova tabela de análise.

🧐 Ponto de Reflexão: Mesclar vs. Atribuir

Na criação da chave composta (Departamento-Local), utilizamos o Mesclar (Merge) ao invés do Atribuir (Append).

Por que Mesclar é o correto neste caso?

Mesclar (Merge): Combina colunas horizontalmente em uma única linha de registro. É essencial para enriquecer um registro, como adicionar um nome de departamento (outra coluna) ao registro de um colaborador (a linha existente), ou para criar uma chave composta unindo duas colunas na mesma linha.

Atribuir (Append): Combina linhas verticalmente, empilhando o conteúdo de uma tabela sob outra. Não seria útil para criar uma chave única por registro.
