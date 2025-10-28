# Usar imagem oficial do Bun (já vem configurada)
FROM oven/bun:1.1.28

# Definir diretório de trabalho
WORKDIR /app

# Copiar arquivos do projeto
COPY . .

# Instalar dependências
RUN bun install

# Expor a porta padrão (se o Typebot usar 3000, troque se necessário)
EXPOSE 3000

# Rodar o servidor
CMD ["bun", "start"]
