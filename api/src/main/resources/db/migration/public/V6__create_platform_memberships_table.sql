CREATE TABLE platform_memberships
(
    id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id    UUID              NOT NULL,
    role_id    BIGINT            NOT NULL,
    status     membership_status NOT NULL DEFAULT 'ACTIVE',
    created_at TIMESTAMPTZ       NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ       NOT NULL DEFAULT NOW(),
    CONSTRAINT fk_platform_memberships_user
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT fk_platform_memberships_role
        FOREIGN KEY (role_id) REFERENCES roles (id) ON DELETE RESTRICT,
    UNIQUE (user_id, role_id),
    CONSTRAINT platform_memberships_status_check
        CHECK (status IN ('ACTIVE', 'INACTIVE', 'SUSPENDED', 'ENDED'))
);
CREATE INDEX idx_platform_memberships_user_id ON platform_memberships(user_id);
CREATE INDEX idx_platform_memberships_role_id ON platform_memberships(role_id);