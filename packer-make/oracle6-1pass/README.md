### Pre-Requirement 
 - Install packer

### Install Linux

The installation of Linux is now fully automated, requiring only the packer command below. The output is a base box ol6.box for use with vagrant.

```bash
packer build packer_ol6.json
```

root password is Welcome1


####To Do

- Test packer_ol{4..7}.json from Oracle Linux wiki download
- Successfully use ol{4..7}.box in vagrant
