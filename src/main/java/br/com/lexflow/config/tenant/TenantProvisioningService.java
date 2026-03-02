package br.com.lexflow.config.tenant;

import lombok.extern.slf4j.Slf4j;
import org.flywaydb.core.Flyway;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;

@Service
@Slf4j
public class TenantProvisioningService {

    @Autowired
    @Qualifier("publicDataSource")
    private DataSource publicDataSource;

    @Transactional
    public void provision(String tenantId) {
        // 1. Criar schema no PostgreSQL
        JdbcTemplate jdbc = new JdbcTemplate(publicDataSource);
        jdbc.execute(
                "CREATE SCHEMA IF NOT EXISTS \"" + sanitize(tenantId) + "\"");

        // 2. Rodar migrations do tenant no novo schema
        Flyway.configure()
                .dataSource(publicDataSource)
                .schemas(tenantId)
                .locations("classpath:db/migration/tenant")
                .load()
                .migrate();

        log.info("Tenant {} provisionado com sucesso", tenantId);
    }

    private String sanitize(String tenantId) {
        if (!tenantId.matches("^[a-z0-9_]{3,50}$")) {
            throw new IllegalArgumentException(
                    "tenantId inválido: apenas letras minúsculas, números e _");
        }
        return tenantId;
    }
}
