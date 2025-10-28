# Etapa base
FROM node:22-bullseye AS base
WORKDIR /app

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
  python3 make g++ build-essential \
  && rm -rf /var/lib/apt/lists/*

# Copiar arquivos de dependências
COPY package*.json ./

# Instalar dependências (evita erro de peer deps)
RUN npm install --legacy-peer-deps

# Copiar todo o código
COPY . .

# (Opcional) Geração do Prisma Client (se houver banco)
RUN npx prisma generate || echo "Prisma não encontrado, ignorando..."

# Buildar o projeto
RUN npm run build || echo "Build padrão ignorado..."

# Expor porta padrão do Typebot
EXPOSE 3000

# Comando de inicialização
CMD ["npm", "start"]
