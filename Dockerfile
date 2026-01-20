FROM ruby:3.4.7-slim
# Instala dependencias básicas

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    libpq-dev \
    libyaml-dev \
    postgresql-client \
    curl \
    git \
    libvips && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

WORKDIR /rails

#copia apenas os arquivos de gems primeiro para aproveitar o cache
COPY Gemfile Gemfile.lock ./
RUN bundle install

#copia o restante do código
COPY . .

# Expõe a porta padrão do Rails
EXPOSE 3000

# Comando para iniciar o servidor em modo desenvolvimento 
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]


