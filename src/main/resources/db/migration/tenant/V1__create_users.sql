CREATE TABLE users (
    id            UUID         PRIMARY KEY DEFAULT gen_random_uuid(),
    name          VARCHAR(255) NOT NULL,
    email         VARCHAR(255) UNIQUE NOT NULL,
    password      VARCHAR(255) NOT NULL,
    oab_number    VARCHAR(20),
    role          VARCHAR(30)  NOT NULL
                  CHECK (role IN ('ADMIN','LAWYER','ASSISTANT','FINANCIAL','CLIENT','AUDITOR')),
    totp_secret   VARCHAR(100),
    totp_enabled  BOOLEAN      DEFAULT FALSE,
    active        BOOLEAN      DEFAULT TRUE,
    created_at    TIMESTAMP    DEFAULT NOW(),
    updated_at    TIMESTAMP    DEFAULT NOW()
);

CREATE INDEX idx_users_email ON users(email);
