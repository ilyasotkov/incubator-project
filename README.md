# Incubator Project

This is an Exekube project used as an incubator

## Railsgoat Database Backup

- Backup:
    ```sh
    gcloud compute disks \
    snapshot railsgoat-data-1 \
    --snapshot-name railsgoat-snapshot-0
    ```
- Restore:
    ```sh
    gcloud compute disks create \
    railsgoat-data-1 \
    --source-snapshot=railsgoat-snapshot-1 \
    --zone=europe-west1-d \
    --type=pd-standard
    ```
- Use in `modules/railsgoat/values.yaml`:
    ```yaml
    railsgoat-db:
      gcePdName: railsgoat-data-1
    ```
