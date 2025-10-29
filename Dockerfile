# Etapa base
FROM node:22-bullseye AS base
WORKDIR /app

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
  python3 make g++ build-essential \
  && rm -rf /var/lib/apt/lists/*

# Copiar os manifests de dependências
COPY package*.json ./

# Instalar dependências (sem postinstall)
RUN npm ci --ignore-scripts --legacy-peer-deps

# Copiar todo o código
COPY . .

# Gerar Prisma Client se existir
RUN npx prisma generate || echo "Prisma não encontrado, ignorando..."

# FORÇAR build apenas no workspace landing-page
RUN npm run --workspace=landing-page build

EXPOSE 3000

# Iniciar preview do workspace landing-page na porta fornecida pelo Render
CMD ["sh", "-c", "npm run --workspace=landing-page preview -- --host 0.0.0.0 --port $PORT"]
