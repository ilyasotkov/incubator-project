# Incubator Project

This is an Exekube project used as an incubator

## Railsgoat Database Backup

- Backup from running disk:
    ```sh
    gcloud compute disks \
    snapshot <AUTOMATICALLY-CREATED-DISK-ID> \
    --snapshot-name railsgoat-snapshot-1
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
