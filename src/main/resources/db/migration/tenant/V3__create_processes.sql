CREATE TABLE processes (
    id                   UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    cnj_number           VARCHAR(30) UNIQUE NOT NULL,
    court                VARCHAR(100),
    section              VARCHAR(100),
    process_class        VARCHAR(100),
    subject              VARCHAR(255),
    status               VARCHAR(30) DEFAULT 'ACTIVE'
                         CHECK (status IN
                         ('ACTIVE','WAITING_ACTION','CONCLUDED','SUSPENDED','ARCHIVED')),
    risk_score           INTEGER     CHECK (risk_score BETWEEN 0 AND 100),
    ai_strategy          TEXT,
    distribution_date    DATE,
    last_sync            TIMESTAMP,
    tribunal_api_status  VARCHAR(20) DEFAULT 'UNKNOWN',
    unread_movements     INTEGER     DEFAULT 0,
    client_id            UUID        NOT NULL REFERENCES clients(id),
    lawyer_id            UUID        NOT NULL REFERENCES users(id),
    created_at           TIMESTAMP   DEFAULT NOW(),
    updated_at           TIMESTAMP   DEFAULT NOW()
);

CREATE INDEX idx_processes_status ON processes(status);
CREATE INDEX idx_processes_lawyer ON processes(lawyer_id);
CREATE INDEX idx_processes_client ON processes(client_id);
