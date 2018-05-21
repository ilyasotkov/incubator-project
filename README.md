# Incubator Project

This is an Exekube project used as an incubator

## Features incubated

## Storage

> We use the [`railsgoat`](https://github.com/ilyasotkov/incubator-project/tree/master/modules/railsgoat) module / application to incubate the features

### pd-pvc chart

`pd-pvc` subchart allows to create PV and PVC from a GCE Persistent Disk (which in turn was probably created from a snapshot)

### cloudsql module

`cloudsql` module allows to create a [Cloud SQL](https://cloud.google.com/sql/docs/postgres/) instance with `proxyuser` user.

### gcloud-sqlproxy chart

`gcloud-sqlproxy` subchart (slightly modified version of `stable/gcloud-sqlproxy`) allows to use a Cloud SQL instance instead of `postgres` subchart.

### snapshot-controller module and chart

`snapshot-controller` adds CRD `kind: VolumeSnapshot` via [kubernetes-incubator/external-storage](https://github.com/kubernetes-incubator/external-storage)
