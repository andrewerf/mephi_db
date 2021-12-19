insert into source(name, fields)
values ('dg', '["cloud_map", "stereo_number"]'),
       ('planet', '["cloud_map"]'),
       ('ntsomz', '["hash", "scene", "selected", "defects"]');

insert into product(type, delivery, indexed_datetime)
values ('simple', '1', now()),
       ('simple', '1', now()),
       ('simple', '1', now());

insert into image(external_id, source_id, sat, type, path, ql_path)
values ('KV_1', 3, 'kv5', 'ms', '', ''),
       ('KV_2', 3, 'kv5', 'ms', '', ''),
       ('KV_3', 3, 'kv5', 'ms', '', '');

insert into image_ntsomz(hash, scene, selected)
values ('4321', 1, true),
       ('5312', 2, true),
       ('5851', 3, false);

insert into vector_class(short_description, long_description, color)
values ('forest', 'Forest', '{0, 255, 0}');

insert into author(name, contacts)
values ('{"Andrew", "Aralov", "Andreevich"}', '{"email": "andrew-aralov@yandex.ru", "telegram": "t.me/async_andrew"}');

insert into vector(class_id, image_id)
values (1, 1),
       (1, 2),
       (1, 3),
       (1, 3);

insert into dataset(parent_id)
values (NULL);

insert into vector_image_dataset(vector_id, dataset_id, image_id)
values (1, 1, 1),
       (1, 1, 2),
       (2, 1, 2),
       (3, 1, 3),
       (4, 1, 3);

insert into experiment(author_id, datetime, git_commit, dataset_id, parent_id)
values (1, now(), '4312jb3xd12h3iu1h31', 1, NULL),
       (1, now(), '98789889439fanbw78q', 1, 1),
       (1, now(), '7889210372810218936', 1, NULL);

insert into model(experiment_id, type, paths)
values (1, 'segmentation', '{"s3:/models/segmentation/log/landcover_all.onnx"}'),
       (2, 'segmentation', '{"s3:/models/segmentation/stable/landcover_all.onnx"}'),
       (3, 'dehazing', '{"s3:/models/dehazing/log/dehazing.hdf5"}');
