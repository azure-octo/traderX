extension radius

// Parameters
param application string

// ghcr.io/finos/traderx
param registry string = 'rynowak.azurecr.io/traderx'
param tag string = 'latest'

var password = 'StrongPassw0rd'

resource database 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'database'
  properties: {
    application: application
    container: {
      image: '${registry}/sql-database:${tag}'
      env: {
        MSSQL_SA_PASSWORD: {
          value: password
        }
      }
      ports: {
        sql: {
          containerPort: 1433
        }
      }
    }
  }
}

resource referencedata 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'reference-data'
  properties: {
    application: application
    container: {
      image: '${registry}/reference-data:${tag}'
      ports: {
        web: {
          containerPort: 18085
        }
      }
    }
  }
}

resource tradefeed 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'trade-feed'
  properties: {
    application: application
    container: {
      image: '${registry}/trade-feed:${tag}'
      ports: {
        web: {
          containerPort: 18086
        }
      }
    }
  }
}

resource peopleservice 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'people-service'
  properties: {
    application: application
    container: {
      image: '${registry}/people-service:${tag}'
      ports: {
        web: {
          containerPort: 18089
        }
      }
    }
  }
}

resource accountservice 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'account-service'
  properties: {
    application: application
    container: {
      image: '${registry}/account-service:${tag}'
      ports: {
        web: {
          containerPort: 18088
        }
      }
      env: {
        DATABASE_TCP_HOST: {
          value: database.name
        }
        DATABASE_TCP_PORT: {
          value: '1433'
        }
        DATABASE_NAME: {
          value: 'master'
        }
        DATABASE_DBUSER: {
          value: 'sa'
        }
        DATABASE_DBPASS: {
          value: 'StrongPassw0rd'
        }
        DATABASE_DIALECT: { 
          value: 'org.hibernate.dialect.SQLServerDialect'
        }
        PEOPLE_SERVICE_HOST: {
          value: peopleservice.name
        }
      }
    }
    connections: {
      peopleservice: {
        source: peopleservice.id
      }
      db: {
        source: database.id
      }
    }
  }
}

resource positionservice 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'position-service'
  properties: {
    application: application
    container: {
      image: '${registry}/position-service:${tag}'
      ports: {
        web: {
          containerPort: 18090
        }
      }
      env: {
        DATABASE_TCP_HOST: {
          value: database.name
        }
        DATABASE_TCP_PORT: {
          value: '1433'
        }
        DATABASE_NAME: {
          value: 'master'
        }
        DATABASE_DBUSER: {
          value: 'sa'
        }
        DATABASE_DBPASS: {
          value: 'StrongPassw0rd'
        }
        DATABASE_DIALECT: { 
          value: 'org.hibernate.dialect.SQLServerDialect'
        }
      }
    }
    connections: {
      db: {
        source: database.id
      }
    }
  }
}

resource tradeservice 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'trade-service'
  properties: {
    application: application
    container: {
      image: '${registry}/trade-service:${tag}'
      ports: {
        web: {
          containerPort: 18092
        }
      }
      env: {
        DATABASE_TCP_HOST: {
          value: database.name
        }
        DATABASE_TCP_PORT: {
          value: '1433'
        }
        DATABASE_NAME: {
          value: 'master'
        }
        DATABASE_DBUSER: {
          value: 'sa'
        }
        DATABASE_DBPASS: {
          value: 'StrongPassw0rd'
        }
        DATABASE_DIALECT: { 
          value: 'org.hibernate.dialect.SQLServerDialect'
        }
        PEOPLE_SERVICE_HOST: {
          value: peopleservice.name
        }
        ACCOUNT_SERVICE_HOST: {
          value: accountservice.name
        }
        REFERENCE_DATA_HOST: {
          value: referencedata.name
        }
        TRADE_FEED_HOST: {
          value: tradefeed.name
        }
      }
    }
    connections: {
      db: {
        source: database.id
      }
      peopleservice: {
        source: peopleservice.id
      }
      accountservice: {
        source: accountservice.id
      }
      referencedata: {
        source: referencedata.id
      }
      tradefeed: {
        source: tradefeed.id
      }
    }
  }
}

resource tradeprocessor 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'trade-processor'
  properties: {
    application: application
    container: {
      image: '${registry}/trade-processor:${tag}'
      ports: {
        web: {
          containerPort: 18091
        }
      }
      env: {
        DATABASE_TCP_HOST: {
          value: database.name
        }
        DATABASE_TCP_PORT: {
          value: '1433'
        }
        DATABASE_NAME: {
          value: 'master'
        }
        DATABASE_DBUSER: {
          value: 'sa'
        }
        DATABASE_DBPASS: {
          value: 'StrongPassw0rd'
        }
        DATABASE_DIALECT: { 
          value: 'org.hibernate.dialect.SQLServerDialect'
        }
        TRADE_FEED_HOST: {
          value: tradefeed.name
        }
      }
    }
    connections: {
      db: {
        source: database.id
      }
      tradefeed: {
        source: tradefeed.id
      }
    }
  }
}

resource webfrontend 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'web-front-end-angular'
  properties: {
    application: application
    container: {
      image: '${registry}/web-front-end-angular:${tag}'
      ports: {
        web: {
          containerPort: 18093
        }
      }
      env: {
        DATABASE_TCP_HOST: {
          value: database.name
        }
      }
    }
    connections: {
      db: {
        source: database.id
      }
      tradefeed: {
        source: tradefeed.id
      }
    }
  }
}

resource ingress 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'ingress'
  properties: {
    application: application
    container: {
      image: '${registry}/ingress:${tag}'
      ports: {
        web: {
          containerPort: 8080
        }
      }
    }
    connections: {
      tradefeed: {
        source: tradefeed.id
      }
      peopleservice: {
        source: peopleservice.id
      }
      accountservice: {
        source: accountservice.id
      }
      positionservice: {
        source: positionservice.id
      }
      tradeservice: {
        source: tradeservice.id
      }
      tradeprocessor: {
        source: tradeprocessor.id
      }
      webfrontend: {
        source: webfrontend.id
      }
    }
  }
}
