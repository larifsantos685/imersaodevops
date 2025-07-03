# Use uma imagem Python oficial e leve como imagem base.
# A tag "slim" garante uma imagem menor, ideal para produção.
FROM python:3.11-slim

# Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache de camadas do Docker.
# Se o requirements.txt não mudar, esta camada não será reconstruída.
COPY requirements.txt .

# Instala as dependências.
# A flag --no-cache-dir desabilita o cache do pip, reduzindo o tamanho da imagem.
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho.
COPY . .

# Expõe a porta 8000 para que a aplicação possa ser acessada de fora do contêiner.
EXPOSE 8000

# Comando para executar a aplicação quando o contêiner iniciar.
# --host 0.0.0.0 é essencial para tornar a aplicação acessível externamente.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]