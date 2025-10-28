# Etapa base
FROM oven/bun:1 AS base
WORKDIR /app

# Instalar dependências do sistema para node-gyp (necessárias para o isolated-vm)
RUN apt-get update && apt-get install -y \
  python3 \
  make \
  g++ \
  build-essential \
  && rm -rf /var/lib/apt/lists/*

# Copiar os arquivos de dependências
COPY bun.lockb package.json ./

# Instalar dependências do projeto
RUN bun install --frozen-lockfile

# Copiar o restante do código
COPY . .

# Expor a porta da aplicação
EXPOSE 3000

# Comando padrão para iniciar o app
CMD ["bun", "run", "start"]
