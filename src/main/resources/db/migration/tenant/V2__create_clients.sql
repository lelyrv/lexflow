CREATE TABLE clients (
    id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    name             VARCHAR(255) NOT NULL,
    cpf_cnpj         VARCHAR(18)  UNIQUE NOT NULL,
    email            VARCHAR(255),
    phone            VARCHAR(20),
    address          TEXT,
    type             VARCHAR(10)  CHECK (type IN ('PF','PJ','PUBLIC')),
    status           VARCHAR(20)  DEFAULT 'ACTIVE',
    nps_score        INTEGER,
    funnel_stage     VARCHAR(30)  DEFAULT 'LEAD'
                     CHECK (funnel_stage IN
                     ('LEAD','CONSULTATION','PROPOSAL','CONTRACTED','CLOSED')),
    lead_source      VARCHAR(50),
    delinquent       BOOLEAN      DEFAULT FALSE,
    assigned_lawyer  UUID,
    created_at       TIMESTAMP    DEFAULT NOW(),
    updated_at       TIMESTAMP    DEFAULT NOW()
);

CREATE INDEX idx_clients_cpf_cnpj ON clients(cpf_cnpj);
CREATE INDEX idx_clients_status   ON clients(status);
