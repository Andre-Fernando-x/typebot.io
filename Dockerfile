FROM node:20-bullseye AS base
WORKDIR /app

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
  python3 make g++ build-essential \
  && rm -rf /var/lib/apt/lists/*

# Copiar package.jsons
COPY package*.json ./

# Instalar dependências (sem rodar postinstall)
RUN npm install --legacy-peer-deps --ignore-scripts

# Copiar o restante do código
COPY . .

# Build opcional (caso exista)
RUN npm run build || echo "Build ignorado..."

# Expor porta padrão
EXPOSE 3000

# Rodar servidor
CMD ["npm", "start"]
