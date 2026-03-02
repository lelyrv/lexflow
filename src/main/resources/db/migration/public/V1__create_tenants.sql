CREATE TABLE IF NOT EXISTS tenants (
    id             VARCHAR(50)  PRIMARY KEY,
    name           VARCHAR(255) NOT NULL,
    email          VARCHAR(255) UNIQUE NOT NULL,
    plan           VARCHAR(20)  DEFAULT 'STARTER'
                   CHECK (plan IN ('STARTER','PROFESSIONAL','ENTERPRISE')),
    active         BOOLEAN      DEFAULT TRUE,
    subdomain      VARCHAR(100) UNIQUE,
    logo_url       TEXT,
    primary_color  VARCHAR(7)   DEFAULT '#1A3356',
    custom_domain  VARCHAR(255),
    created_at     TIMESTAMP    DEFAULT NOW(),
    updated_at     TIMESTAMP    DEFAULT NOW()
);

-- Tenant de dev automático
INSERT INTO tenants (id, name, email, plan, subdomain)
VALUES ('dev', 'Escritório Dev', 'admin@dev.com', 'ENTERPRISE', 'dev')
ON CONFLICT DO NOTHING;
