# ========================================================================================

# ========================================================================================

# spacetime: describes some physical area

create table spacetimes
(
    id          bigint unsigned auto_increment primary key,
    created_at  timestamp null,
    updated_at  timestamp null
)
    collate = utf8mb4_unicode_ci;


# ========================================================================================


# reference frame

create table reference_frames
(
    id         bigint unsigned auto_increment primary key,
    name       varchar(255) not null,
    created_at timestamp null,
    updated_at timestamp null
)
    collate = utf8mb4_unicode_ci;


# ========================================================================================


# manifolds: curves, surfaces, 4-dimensional manifolds etc.

create table curves
(
    id                 bigint unsigned auto_increment primary key,
    reference_frame_id bigint unsigned not null,
    spacetime_id       bigint unsigned not null,
    # ct x
    created_at         timestamp null,
    updated_at         timestamp null,
    constraint curves_reference_frame_id_foreign
        foreign key (reference_frame_id) references reference_frames (id),
    constraint curves_spacetime_id_foreign
        foreign key (spacetime_id) references spacetimes (id)
)
    collate = utf8mb4_unicode_ci;

create table surfaces
(
    id                 bigint unsigned auto_increment primary key,
    reference_frame_id bigint unsigned not null,
    spacetime_id       bigint unsigned not null,
    # ct x y
    created_at         timestamp null,
    updated_at         timestamp null,
    constraint surfaces_reference_frame_id_foreign
        foreign key (reference_frame_id) references reference_frames (id),
    constraint surfaces_spacetime_id_foreign
        foreign key (spacetime_id) references spacetimes (id)
)
    collate = utf8mb4_unicode_ci;

create table manifolds
(
    id                 bigint unsigned auto_increment primary key,
    reference_frame_id bigint unsigned not null,
    spacetime_id       bigint unsigned not null,
    # ct x y z
    created_at         timestamp null,
    updated_at         timestamp null,
    constraint manifolds_reference_frame_id_foreign
        foreign key (reference_frame_id) references reference_frames (id),
    constraint manifolds_spacetime_id_foreign
        foreign key (spacetime_id) references spacetimes (id)
)
    collate = utf8mb4_unicode_ci;


# ========================================================================================

# interface: describes behaviour

create table interfaces
(
    id         bigint unsigned auto_increment primary key,
    name       varchar(255) not null,
    created_at timestamp null,
    updated_at timestamp null
)
    collate = utf8mb4_unicode_ci;


# ========================================================================================

# particle: spacetime-interface relation (parts of concrete thing that implements concrete interface)

create table particles
(
    id              bigint unsigned auto_increment primary key,
    interface_id    bigint unsigned not null,
    spacetime_id    bigint unsigned not null,
    created_at      timestamp null,
    updated_at      timestamp null,
    constraint particles_interface_id_foreign
        foreign key (interface_id) references interfaces (id),
    constraint particles_spacetime_id_foreign
        foreign key (spacetime_id) references spacetimes (id)
)
    collate = utf8mb4_unicode_ci;


# ========================================================================================

create table curve_particle
(
    id                 bigint unsigned auto_increment primary key,
    curve_id           bigint unsigned not null,
    particle_id        bigint unsigned not null,
    created_at         timestamp null,
    updated_at         timestamp null,
    constraint curve_particle_curve_id_foreign
        foreign key (curve_id) references curves (id),
    constraint curve_particle_particle_id_foreign
        foreign key (particle_id) references particles (id)
)
    collate = utf8mb4_unicode_ci;

create table particle_surface
(
    id                 bigint unsigned auto_increment primary key,
    particle_id        bigint unsigned not null,
    surface_id         bigint unsigned not null,
    created_at         timestamp null,
    updated_at         timestamp null,
    constraint particle_surface_surface_id_foreign
        foreign key (surface_id) references surfaces (id),
    constraint particle_surface_particle_id_foreign
        foreign key (particle_id) references particles (id)
)
    collate = utf8mb4_unicode_ci;

create table manifold_particle
(
    id                 bigint unsigned auto_increment primary key,
    manifold_id        bigint unsigned not null,
    particle_id        bigint unsigned not null,
    created_at         timestamp null,
    updated_at         timestamp null,
    constraint manifold_particle_manifold_id_foreign
        foreign key (manifold_id) references manifolds (id),
    constraint manifold_particle_particle_id_foreign
        foreign key (particle_id) references particles (id)
)
    collate = utf8mb4_unicode_ci;

# ========================================================================================

# Objects: terrain resources, units, settlements, cities, civilizations, civics, technologies


create table terrain_resources
(
    id         bigint unsigned auto_increment
        primary key,
    name       varchar(255) null, # 'apple', 'wheat', 'fish', 'horses', 'bronze', 'iron', 'coal', 'oil', 'uranium'
    created_at timestamp null,
    updated_at timestamp null
)
    collate = utf8mb4_unicode_ci;

create table particle_terrain_resource
(
    id                  bigint unsigned auto_increment primary key,
    terrain_resource_id bigint unsigned not null,
    particle_id         bigint unsigned not null,
    created_at          timestamp null,
    updated_at          timestamp null,
    constraint particle_terrain_resource_particle_id_foreign
        foreign key (particle_id) references particles (id),
    constraint particle_terrain_resource_terrain_resource_id_foreign
        foreign key (terrain_resource_id) references terrain_resources (id)
)
    collate = utf8mb4_unicode_ci;


create table units
(
    id               bigint unsigned auto_increment primary key,
    name             varchar(255) null,
    created_at       timestamp null,
    updated_at       timestamp null
)
    collate = utf8mb4_unicode_ci;

create table particle_unit
(
    id              bigint unsigned auto_increment primary key,
    particle_id     bigint unsigned not null,
    unit_id         bigint unsigned not null,
    created_at      timestamp null,
    updated_at      timestamp null,
    constraint particle_unit_particle_id_foreign
        foreign key (particle_id) references particles (id),
    constraint particle_unit_unit_id_foreign
        foreign key (unit_id) references units (id)
)
    collate = utf8mb4_unicode_ci;

create table unit_contacts
(
    id              bigint unsigned auto_increment primary key,
    unit_1_id       bigint unsigned not null,
    unit_2_id       bigint unsigned not null,
    created_at      timestamp null,
    updated_at      timestamp null,
    constraint unit_contacts_unit_1_id_foreign
        foreign key (unit_1_id) references units (id),
    constraint unit_contacts_unit_2_id_foreign
        foreign key (unit_2_id) references units (id)
)
    collate = utf8mb4_unicode_ci;

create table buildings
(
    id              bigint unsigned auto_increment primary key,
    name            varchar(255) null,
    created_at      timestamp null,
    updated_at      timestamp null
)
    collate = utf8mb4_unicode_ci;

create table building_particle
(
    id              bigint unsigned auto_increment primary key,
    building_id     bigint unsigned not null,
    particle_id     bigint unsigned not null,
    created_at      timestamp null,
    updated_at      timestamp null,
    constraint building_particle_particle_id_foreign
        foreign key (particle_id) references particles (id),
    constraint building_particle_unit_id_foreign
        foreign key (building_id) references buildings (id)
)
    collate = utf8mb4_unicode_ci;

create table settlements
(
    id              bigint unsigned auto_increment primary key,
    name            varchar(255) null,
    created_at      timestamp null,
    updated_at      timestamp null
)
    collate = utf8mb4_unicode_ci;

create table settlement_particle
(
    id              bigint unsigned auto_increment primary key,
    settlement_id   bigint unsigned not null,
    particle_id     bigint unsigned not null,
    created_at      timestamp null,
    updated_at      timestamp null,
    constraint settlement_particle_particle_id_foreign
        foreign key (particle_id) references particles (id),
    constraint settlement_particle_unit_id_foreign
        foreign key (settlement_id) references settlements (id)
)
    collate = utf8mb4_unicode_ci;

create table settlement_unit
(
    id              bigint unsigned auto_increment primary key,
    settlement_id   bigint unsigned not null,
    unit_id         bigint unsigned not null,
    created_at      timestamp null,
    updated_at      timestamp null,
    constraint settlement_unit_settlement_id_foreign
        foreign key (settlement_id) references settlements (id),
    constraint settlement_unit_unit_id_foreign
        foreign key (unit_id) references units (id)
)
    collate = utf8mb4_unicode_ci;

create table civilizations
(
    id               bigint unsigned auto_increment primary key,
    name             varchar(255) null,
    created_at       timestamp null,
    updated_at       timestamp null
)
    collate = utf8mb4_unicode_ci;

create table civilization_particle
(
    id              bigint unsigned auto_increment primary key,
    civilization_id bigint unsigned not null,
    particle_id     bigint unsigned not null,
    created_at      timestamp null,
    updated_at      timestamp null,
    constraint civilization_particle_civilization_id_foreign
        foreign key (civilization_id) references civilizations (id),
    constraint civilization_particle_particle_id_foreign
        foreign key (particle_id) references particles (id)
)
    collate = utf8mb4_unicode_ci;

create table civilization_contacts
(
    id                bigint unsigned auto_increment primary key,
    civilization_1_id bigint unsigned not null,
    civilization_2_id bigint unsigned not null,
    created_at        timestamp null,
    updated_at        timestamp null,
    constraint civilization_contacts_civilization_1_id_foreign
        foreign key (civilization_1_id) references civilizations (id),
    constraint civilization_contacts_civilization_2_id_foreign
        foreign key (civilization_2_id) references civilizations (id)
)
    collate = utf8mb4_unicode_ci;

create table civilization_unit
(
    id              bigint unsigned auto_increment primary key,
    civilization_id bigint unsigned not null,
    unit_id         bigint unsigned not null,
    created_at      timestamp null,
    updated_at      timestamp null,
    constraint civilization_unit_civilization_id_foreign
        foreign key (civilization_id) references civilizations (id),
    constraint civilization_unit_unit_id_foreign
        foreign key (unit_id) references units (id)
)
    collate = utf8mb4_unicode_ci;

create table civilization_settlement
(
    id              bigint unsigned auto_increment primary key,
    civilization_id bigint unsigned not null,
    settlement_id   bigint unsigned not null,
    created_at      timestamp null,
    updated_at      timestamp null,
    constraint civilization_settlement_civilization_id_foreign
        foreign key (civilization_id) references civilizations (id),
    constraint civilization_settlement_settlement_id_foreign
        foreign key (settlement_id) references settlements (id)
)
    collate = utf8mb4_unicode_ci;

create table technologies
(
    id              bigint unsigned auto_increment primary key,
    name            varchar(255) null,
    created_at      timestamp null,
    updated_at      timestamp null
)
    collate = utf8mb4_unicode_ci;

create table technology_particle
(
    id              bigint unsigned auto_increment primary key,
    particle_id     bigint unsigned not null,
    technology_id   bigint unsigned not null,
    created_at      timestamp null,
    updated_at      timestamp null,
    constraint technology_particle_particle_id_foreign
        foreign key (particle_id) references particles (id),
    constraint technology_particle_technology_id_foreign
        foreign key (technology_id) references technologies (id)
)
    collate = utf8mb4_unicode_ci;

create table civilization_technology
(
    id              bigint unsigned auto_increment primary key,
    civilization_id bigint unsigned not null,
    technology_id   bigint unsigned not null,
    created_at      timestamp null,
    updated_at      timestamp null,
    constraint civilization_technology_civilization_id_foreign
        foreign key (civilization_id) references civilizations (id),
    constraint civilization_technology_technology_id_foreign
        foreign key (technology_id) references technologies (id)
)
    collate = utf8mb4_unicode_ci;

create table civics
(
    id              bigint unsigned auto_increment primary key,
    name            varchar(255) null,
    created_at      timestamp null,
    updated_at      timestamp null
)
    collate = utf8mb4_unicode_ci;

create table civic_particle
(
    id              bigint unsigned auto_increment primary key,
    civic_id        bigint unsigned not null,
    particle_id     bigint unsigned not null,
    created_at      timestamp null,
    updated_at      timestamp null,
    constraint civic_particle_particle_id_foreign
        foreign key (particle_id) references particles (id),
    constraint civic_particle_civic_id_foreign
        foreign key (civic_id) references civics (id)
)
    collate = utf8mb4_unicode_ci;

create table civic_civilization
(
    id              bigint unsigned auto_increment primary key,
    civic_id        bigint unsigned not null,
    civilization_id bigint unsigned not null,
    created_at      timestamp null,
    updated_at      timestamp null,
    constraint civic_civilization_civic_id_foreign
        foreign key (civic_id) references civics (id),
    constraint civic_civilization_civilization_id_foreign
        foreign key (civilization_id) references civilizations (id)
)
    collate = utf8mb4_unicode_ci;


# ========================================================================================

# ========================================================================================


# create table promotion_types
# (
#     id         bigint unsigned auto_increment
#         primary key,
#     name       varchar(255) not null,
#     created_at timestamp    null,
#     updated_at timestamp    null
# )
#     collate = utf8mb4_unicode_ci;

# create table promotions
# (
#     id                bigint unsigned auto_increment
#         primary key,
#     promotion_type_id bigint unsigned not null,
#     unit_id           bigint unsigned not null,
#     created_at        timestamp       null,
#     updated_at        timestamp       null,
#     constraint promotions_promotion_type_id_foreign
#         foreign key (promotion_type_id) references promotion_types (id),
#     constraint promotions_unit_id_foreign
#         foreign key (unit_id) references units (id)
# )
#     collate = utf8mb4_unicode_ci;

