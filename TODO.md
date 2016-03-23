Ideas for stuff to do.

# Chaining/layering functionality
Makefiles seem to work more effectively than packer natively for handling chains
of builds.

# OVA/OVF all the things
Just about everything seems to accept OVA/OVF. It might make sense to have that
be the standard format for the class of appopriate targets (excluding Docker,
etc).

# Repo layout
I dislike how the layered approach is creating hideously long names. There may
be a better way to accomplish what I want.

# yml2json
TravisCI has a packer-templates repo that uses yml for their templates and
converts it to the packer json format. This has the added advantage of allowing
comments and may provide other advantages.

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
