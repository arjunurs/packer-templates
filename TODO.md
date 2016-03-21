Ideas for stuff to do.

# Box versioning
Vagrant boxes have a metadata.json file which allows for box versioning. Packer
doesn't make use of that functionality through the vagrant post processor
currently. Extend it to do so.

# kickstart CGI/Templates
Extend Packer's HTTP (Go's net/http AFAICT) server to allow CGI OR render
templates. This would permit more reuse.

# Travis CI builds
Get some Travis CI going for this repo to build boxes.

# Version RHEL based boxes by checksum of all installed packages
```
echo $(rpm -qa | sort | md5sum)
```

# Build triggers
## Nightly builds
cron job!

## Package versions
Export a list of installed packages for a box. Trigger a build when any package
is updated. Could conceivably be used in concert with automation for yumrepo
mirroring.
