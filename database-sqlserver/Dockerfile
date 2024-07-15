FROM mcr.microsoft.com/mssql/server:2022-latest

WORKDIR /config
COPY . /config

ENTRYPOINT ["/config/entrypoint.sh"]