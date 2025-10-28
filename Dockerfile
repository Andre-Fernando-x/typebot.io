# Etapa base
FROM node:22-bullseye AS base
WORKDIR /app

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
  python3 make g++ build-essential \
  && rm -rf /var/lib/apt/lists/*

# Copiar os manifests de dependências
COPY package*.json ./

# Instalar dependências (sem rodar o postinstall do Turbo)
RUN npm install --ignore-scripts --legacy-peer-deps

# Copiar todo o código
COPY . .

# Gerar Prisma Client se existir
RUN npx prisma generate || echo "Prisma não encontrado, ignorando..."

# Buildar o projeto (necessário pro painel do Typebot)
RUN npm run build || echo "Build ignorado..."

# Expor a porta padrão
EXPOSE 3000

# Iniciar o servidor
CMD ["npm", "start"]
