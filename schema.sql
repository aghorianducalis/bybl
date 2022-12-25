
# ========================================================================================

create table manifolds
(
#     id         bigint unsigned auto_increment primary key,
    a          bigint unsigned,
    b          bigint unsigned,
    c          bigint unsigned,
    d          bigint unsigned
)
    collate = utf8mb4_unicode_ci;

# ========================================================================================

create table states
(
    id         bigint unsigned auto_increment primary key,
    name       varchar(255) # value, etc.
    # ...
)
    collate = utf8mb4_unicode_ci;

# ========================================================================================

create table conditions
(
    id         bigint unsigned auto_increment primary key
    # ...
)
    collate = utf8mb4_unicode_ci;

# ========================================================================================
