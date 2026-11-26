# Releases

Releases are numbered by date (`YYYYMMDD`). Newest first.

### 20261125

#### Features
- [GENERAL] `RELEASE.md` tracks each release by date with its changes.

#### Improvements
- [ICEBERG] SeaweedFS replaces MinIO for S3 storage.
- [ICEBERG] Dependencies upgraded: Lakekeeper 0.15.0, PostgreSQL 18.7, Trino 484, Iceberg 1.12.0, pyspark 4.1.4, pyiceberg 0.12.0.
- [ICEBERG] Containers run as your user, so files they write are owned by you, not root.
- [ICEBERG] `./dclean` removes everything the notebooks wrote, including files that used to be owned by root.
- [ICEBERG] Lakekeeper, PostgreSQL, Trino, and SeaweedFS use upstream images, so there are fewer images to build.
- [ICEBERG] Jupyter image builds faster and is smaller, with cached downloads and a headless Java runtime.
- [ICEBERG] Spark no longer creates `spark-warehouse` folders in the notebook folders.
- [ICEBERG] Spark startup is quieter; the "Setting default log level" message is gone.

#### Fixes
- [ICEBERG] Spark sessions no longer fail with `Invalid UID`.
- [ICEBERG] Notebooks no longer reference Nessie, which removes the `ClassNotFoundException` noise from Spark logs.
- [ICEBERG] `dbuild`, `drun`, and `dclean` use a proper shebang.

#### Known Issues
- [ICEBERG] Each Spark session still prints a harmless `WARNING: Using incubator modules: jdk.incubator.vector` from Java.
