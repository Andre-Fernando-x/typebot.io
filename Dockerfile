FROM node:20-bullseye AS base
WORKDIR /app

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
  python3 make g++ build-essential \
  && rm -rf /var/lib/apt/lists/*

# Copiar package.jsons do monorepo
COPY package*.json ./

# Instalar dependências com tolerância de conflitos
RUN npm install --legacy-peer-deps

# Copiar todo o projeto
COPY . .

# Construir o builder (se existir)
RUN npm run build || echo "Build opcional - ignorado"

# Expor porta padrão
EXPOSE 3000

# Rodar o servidor principal do Typebot (ajuste se necessário)
CMD ["npm", "start"]
