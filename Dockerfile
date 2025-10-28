# Usar imagem Node LTS
FROM node:20-bullseye AS base

# Criar diretório de trabalho
WORKDIR /app

# Instalar dependências de sistema para módulos nativos
RUN apt-get update && apt-get install -y \
  python3 \
  make \
  g++ \
  build-essential \
  && rm -rf /var/lib/apt/lists/*

# Copiar package.json e package-lock.json (se existir)
COPY package*.json ./

# Instalar dependências
RUN npm install

# Copiar o restante do código
COPY . .

# Gerar build (opcional — apenas se o projeto tiver)
RUN npm run build || echo "Sem build script, seguindo..."

# Expor porta padrão
EXPOSE 3000

# Rodar o servidor
CMD ["npm", "start"]
