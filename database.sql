create table product
(
    id               serial,
    type             varchar default 'simple'::character varying,
    delivery         varchar,
    indexed_datetime timestamp,
    constraint product_pk
        primary key (id)
);

alter table product
    owner to postgres;

create unique index product_id_uindex
    on product (id);

create table vector_class
(
    id                serial,
    short_description varchar,
    long_description  text,
    color             integer[],
    constraint vector_class_pk
        primary key (id)
);

alter table vector_class
    owner to postgres;

create unique index vector_class_id_uindex
    on vector_class (id);

create table vector
(
    id       serial,
    class_id integer default nextval('vector_class_id_seq1'::regclass) not null,
    image_id serial,
    other    json,
    geometry geometry,
    constraint vector_pk
        primary key (id),
    constraint vector_vector_class_id_fk
        foreign key (class_id) references vector_class
);

alter table vector
    owner to postgres;

create unique index vector_id_uindex
    on vector (id);

create table author
(
    id       serial,
    name     character varying[],
    contacts json,
    constraint author_pk
        primary key (id)
);

alter table author
    owner to postgres;

create unique index author_id_uindex
    on author (id);

create table vector_author
(
    vector_id serial,
    author_id serial,
    model_id  serial,
    constraint vector_author_vector_id_fk
        foreign key (vector_id) references vector,
    constraint vector_author_author_id_fk
        foreign key (author_id) references author
);

alter table vector_author
    owner to postgres;

create table dataset
(
    id        serial,
    parent_id serial,
    constraint dataset_pkey
        primary key (id),
    constraint dataset_parent_id_fkey
        foreign key (parent_id) references dataset
);

alter table dataset
    owner to postgres;

create table source
(
    id     serial,
    name   varchar not null,
    fields json    not null,
    constraint source_pk
        primary key (id)
);

alter table source
    owner to postgres;

create table image
(
    id                 serial,
    external_id        varchar not null,
    source_id          integer not null,
    sat                varchar not null,
    capture_conditions json,
    captured_datetime  timestamp,
    processed_datetime timestamp,
    type               varchar,
    geometry           geometry,
    path               varchar,
    ql_path            varchar,
    other_paths        character varying[],
    product_id         serial,
    constraint image_pk
        primary key (id),
    constraint image_product_id_fk
        foreign key (product_id) references product,
    constraint image_source_id_fk
        foreign key (source_id) references source
);

alter table image
    owner to postgres;

create unique index image_id_uindex
    on image (id);

create table image_planet
(
    id        serial,
    cloud_map geometry,
    constraint image_planet_image_id_fk
        foreign key (id) references image
            on update cascade on delete cascade
);

alter table image_planet
    owner to postgres;

create table image_dg
(
    id            serial,
    cloud_map     geometry,
    stereo_number integer,
    constraint image_dg_image_id_fk
        foreign key (id) references image
            on update cascade on delete cascade
);

alter table image_dg
    owner to postgres;

create table image_ntsomz
(
    id       serial,
    hash     varchar not null,
    scene    integer not null,
    selected boolean not null,
    defects  character varying[],
    constraint image_ntsomz_image_id_fk
        foreign key (id) references image
            on update cascade on delete cascade
);

alter table image_ntsomz
    owner to postgres;

create table vector_image_dataset
(
    vector_id  integer default nextval('vector_dataset_vector_id_seq'::regclass)  not null,
    dataset_id integer default nextval('vector_dataset_dataset_id_seq'::regclass) not null,
    image_id   integer                                                            not null,
    constraint vector_dataset_vector_id_fkey
        foreign key (vector_id) references vector,
    constraint vector_dataset_dataset_id_fkey
        foreign key (dataset_id) references dataset,
    constraint vector_image_dataset_image_id_fk
        foreign key (image_id) references image
);

alter table vector_image_dataset
    owner to postgres;

create unique index source_id_uindex
    on source (id);

create table experiment
(
    id         serial,
    author_id  serial,
    datetime   timestamp,
    git_commit varchar not null,
    dataset_id serial,
    parent_id  serial,
    constraint experiment_pkey
        primary key (id),
    constraint experiment_parent_id_fkey
        foreign key (parent_id) references experiment,
    constraint experiment_dataset_id_fkey
        foreign key (dataset_id) references dataset,
    constraint experiment_author_id_fkey
        foreign key (author_id) references author
);

alter table experiment
    owner to postgres;

create table model
(
    id            serial,
    experiment_id serial,
    type          varchar             not null,
    paths         character varying[] not null,
    other         json,
    constraint model_pkey
        primary key (id),
    constraint model_experiment_id_fkey
        foreign key (experiment_id) references experiment
);

alter table model
    owner to postgres;


