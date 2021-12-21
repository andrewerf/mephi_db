create table product
(
    id               serial primary key,
    type             varchar default 'simple',
    delivery         varchar,
    indexed_datetime timestamp
);

create table vector_class
(
    id                serial primary key,
    short_description varchar,
    long_description  text,
    color             integer[]
);

create table source
(
    id     serial primary key,
    name   varchar not null,
    fields json    not null
);

create table image
(
    id                 serial primary key,
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
    product_id         integer,
    foreign key (product_id) references product(id),
    foreign key (source_id) references source(id)
);

create table vector
(
    id       serial primary key,
    class_id integer not null,
    image_id integer,
    other    json,
    geometry geometry,
    foreign key (class_id) references vector_class(id),
    foreign key (image_id) references image(id)
);

create table author
(
    id       serial primary key,
    name     varchar[3],
    contacts json
);

create table dataset
(
    id        serial primary key,
    parent_id integer references dataset(id)
);

create table image_planet
(
    id        integer,
    cloud_map geometry,
    foreign key (id) references image(id)
        on update cascade on delete cascade
);

create table image_dg
(
    id            integer,
    cloud_map     geometry,
    stereo_number integer,
    foreign key (id) references image(id)
        on update cascade on delete cascade
);

create table image_ntsomz
(
    id       integer,
    hash     varchar not null,
    scene    integer not null,
    selected boolean not null,
    defects  character varying[],
    foreign key (id) references image(id)
        on update cascade on delete cascade
);

create table vector_image_dataset
(
    vector_id  integer not null,
    dataset_id integer not null,
    image_id   integer not null,
    foreign key (vector_id) references vector(id),
    foreign key (dataset_id) references dataset(id),
    foreign key (image_id) references image(id)
);

create table experiment
(
    id         serial primary key,
    author_id  integer,
    datetime   timestamp,
    git_commit varchar not null,
    dataset_id integer,
    parent_id  integer,
    foreign key (parent_id) references experiment(id),
    foreign key (dataset_id) references dataset(id),
    foreign key (author_id) references author(id)
);

create table model
(
    id            serial primary key,
    experiment_id integer,
    type          varchar             not null,
    paths         character varying[] not null,
    other         json,
    foreign key (experiment_id) references experiment(id)
);

create table vector_author
(
    vector_id integer,
    author_id integer,
    model_id  integer,
    foreign key (vector_id) references vector(id),
    foreign key (author_id) references author(id),
    foreign key (model_id) references model(id)
);
