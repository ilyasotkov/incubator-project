# Incubator Project

This is an Exekube project used as an incubator

## Manual persistent volume snapshots via railsgoat-restore chart

- Create snapshot from disk:
    ```sh
    xk bash
    ```
    ```sh
    export DISK_NAME=<GCE-PD-NAME>
    ```
    ```sh
    gcloud compute disks \
    snapshot $DISK_NAME \
    --zone europe-west1-d \
    --snapshot-names railsgoat-snapshot-1
    ```
- Simulate disaster:
    ```sh
    xk down live/dev/k8s/default/railsgoat/
    ```
- Create disk from snapshot:
    ```sh
    gcloud compute disks create \
    railsgoat-data-1 \
    --source-snapshot=railsgoat-snapshot-1 \
    --zone=europe-west1-d \
    --type=pd-standard
    ```
- Enable `railsgoat-restore` chart and use `existingClaim` for `postgresql` chart (in `modules/railsgoat/values.yaml`):
    ```yaml
    railsgoat-restore:
      enabled: true
      gcePdName: railsgoat-data-1
    ```
    ```diff
    ## Configuration values for the postgresql dependency.
    ## ref: https://github.com/kubernetes/charts/blob/master/stable/postgresql/README.md
    ##
    +postgresql:
    +  persistence:
    +    enabled: true
    +    existingClaim: railsgoat-db
    ```
