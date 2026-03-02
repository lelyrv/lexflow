package br.com.lexflow.config.tenant;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

import javax.sql.DataSource;
import java.util.HashMap;

@Configuration
public class TenantConfig {

    @Value("${spring.datasource.url}")
    private String url;

    @Value("${spring.datasource.username}")
    private String username;

    @Value("${spring.datasource.password}")
    private String password;

    @Bean(name = "publicDataSource")
    public DataSource publicDataSource() {
        return DataSourceBuilder.create()
                .url(url + "?currentSchema=public")
                .username(username)
                .password(password)
                .build();
    }

    @Bean(name = "tenantDataSource")
    @Primary
    public DataSource tenantDataSource() {
        TenantRoutingDataSource routing = new TenantRoutingDataSource();
        routing.setDefaultTargetDataSource(publicDataSource());
        routing.setTargetDataSources(new HashMap<>());
        routing.afterPropertiesSet();
        return routing;
    }
}
