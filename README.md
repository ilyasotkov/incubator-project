# Incubator Project

This is an Exekube project used as an incubator

## Features incubated

## Storage

> We use the [`railsgoat`](https://github.com/ilyasotkov/incubator-project/tree/master/modules/railsgoat) module / application to incubate the features

1. `pd-pvc` subchart allows to create PV and PVC from a GCE Persistent Disk (which in turn was probably created from a snapshot)
2. `cloudsql` module allows to create a [Cloud SQL](https://cloud.google.com/sql/docs/postgres/) instance with `proxyuser` user.
3. `gcloud-sqlproxy` subchart (slightly modified version of `stable/gcloud-sqlproxy`) allows to use a Cloud SQL instance instead of `postgres` subchart.
