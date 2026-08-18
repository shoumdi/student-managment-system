CREATE TABLE institutes
(
    id         UUID PRIMARY KEY          DEFAULT gen_random_uuid(),
    name       VARCHAR(255)     NOT NULL,
    email      VARCHAR(255),
    phone      VARCHAR(50),
    status     institute_status NOT NULL DEFAULT 'ACTIVE',
    created_at TIMESTAMPTZ      NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ      NOT NULL DEFAULT NOW(),
    CONSTRAINT institutes_status_check
        CHECK (status IN ('ACTIVE', 'INACTIVE', 'SUSPENDED', 'ARCHIVED'))
);
CREATE INDEX idx_institutes_status ON institutes(status);
