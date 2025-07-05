# Use uma imagem Python oficial e leve como base.
FROM python:3.13.5-alpine3.22

# Define o diretório de trabalho dentro do contêiner para /app
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache do Docker.
# Se o requirements.txt não mudar, o Docker não reinstalará as dependências.
COPY requirements.txt .

# Instala as dependências do projeto.
# --no-cache-dir reduz o tamanho final da imagem.
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho.
COPY . .

# Expõe a porta 8000 para que a aplicação possa ser acessada de fora do contêiner.
EXPOSE 8000

# Comando para iniciar a aplicação FastAPI com Uvicorn quando o contêiner for executado.
# O host 0.0.0.0 é essencial para que o servidor seja acessível externamente.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]