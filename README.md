# MFS Master 
## Ports exposed
The mfsmaster needs to listen on following ports
- 9419
- 9420
- 9424

## Volumes
If you want to keep your metadata database persistent, you may link the volume `
/usr/local/var/lib/mfs` to a local drive.

## Environemnt variables
| Variable | default |
| --- | --- |
| MFSM_PERSONALITY | master
| MFSM_MASTERHOST | mfsmaster
| MFSM_REBAL_LABELS | 1
| MFSM_ACCEPT_DIFF | 0.1

## Usage
```
docker run -d --name mfsMaster -e MFSM_PERSONALITY=master slartibartfas81\mfsmaster
```

