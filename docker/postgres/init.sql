-- Schema público: controle de tenants
CREATE SCHEMA IF NOT EXISTS public;

-- Tabela de tenants
CREATE TABLE IF NOT EXISTS public.tenants (
  id          VARCHAR(50)  PRIMARY KEY,
  name        VARCHAR(255) NOT NULL,
  email       VARCHAR(255) UNIQUE NOT NULL,
  plan        VARCHAR(20)  DEFAULT 'STARTER',
  active      BOOLEAN      DEFAULT TRUE,
  subdomain   VARCHAR(100) UNIQUE,
  created_at  TIMESTAMP    DEFAULT NOW()
);

-- Tenant de desenvolvimento para testes locais
INSERT INTO public.tenants (id, name, email, plan, subdomain)
VALUES ('dev', 'Escritório Dev', 'admin@dev.com', 'ENTERPRISE', 'dev')
ON CONFLICT DO NOTHING;
