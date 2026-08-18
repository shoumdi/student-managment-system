CREATE TABLE institute_memberships
(
    id           BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    institute_id UUID              NOT NULL,
    user_id      UUID              NOT NULL,
    role_id      BIGINT            NOT NULL,
    status       membership_status NOT NULL DEFAULT 'ACTIVE',
    joined_at    TIMESTAMPTZ       NOT NULL DEFAULT NOW(),
    ended_at     TIMESTAMPTZ,
    created_at   TIMESTAMPTZ       NOT NULL DEFAULT NOW(),
    updated_at   TIMESTAMPTZ       NOT NULL DEFAULT NOW(),
    CONSTRAINT fk_institute_memberships_institute
        FOREIGN KEY (institute_id) REFERENCES institutes (id) ON DELETE CASCADE,
    CONSTRAINT fk_institute_memberships_user
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT fk_institute_memberships_role
        FOREIGN KEY (role_id) REFERENCES roles (id) ON DELETE RESTRICT,
    UNIQUE (institute_id, user_id, role_id),
    CONSTRAINT institute_memberships_status_check
        CHECK (status IN ('ACTIVE', 'INACTIVE', 'SUSPENDED', 'ENDED'))
);
CREATE INDEX idx_institute_memberships_institute_id ON institute_memberships (institute_id);
CREATE INDEX idx_institute_memberships_user_id ON institute_memberships (user_id);
CREATE INDEX idx_institute_memberships_role_id ON institute_memberships (role_id);
CREATE INDEX idx_institute_memberships_ended_at ON institute_memberships (ended_at) WHERE ended_at IS NOT NULL;