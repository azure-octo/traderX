FROM mcr.microsoft.com/mssql/server:2022-latest

# See: https://hub.docker.com/r/microsoft/mssql-server
ENV ACCEPT_EULA=Y
ENV MSSQL_PID=Evaluation

# Create a config directory
USER root
RUN mkdir -p /init/config
WORKDIR /init/config

# Bundle config source
COPY . /init/config

# Grant permissions for to our scripts to be executable
RUN chmod +x /init/config/entrypoint.sh
RUN chmod +x /init/config/configure-db.sh

EXPOSE 1433
ENTRYPOINT ["./entrypoint.sh"]