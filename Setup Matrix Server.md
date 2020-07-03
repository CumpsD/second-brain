# Matrix.org

## Start instance

Create a new Elastic IP, Key Pair and EC2 instance (I picked a t3.small with Unlimited Disabled, with 20GB and Ubuntu 20.04 LTS).

Also create an S3 bucket.

### Security Group

* `80/tcp` (HTTP webserver)
* `443/tcp` (HTTPS webserver)
* `3478/tcp` (TURN over TCP)
* `3478/udp` (TURN over UDP)
* `5349/tcp` (TURN over TCP)
* `5349/udp` (TURN over UDP)
* `8448/tcp` (Matrix Federation API HTTPS webserver)
* the range `49152-49172/udp` (TURN over UDP)
* `4443/tcp` (Jitsi Harvester fallback)
* `10000/udp` (Jitsi video RTP)

## Configure Instance

### DNS

* `matrix.cumps.be` A record to your Elastic IP
* `riot.cumps.be` CNAME to `matrix.cumps.be`
* `dimension.cumps.be` CNAME to `matrix.cumps.be`
* `jitsi.cumps.be` CNAME to `matrix.cumps.be`
* `_matrix-identity._tcp.cumps.be` SRV to `10 0 443 matrix.cumps.be` (`_matrix-identity._tcp    6h  IN      SRV     10 0 443 matrix.cumps.be.`)

### Update Packages

```bash
sudo apt-get update
sudo apt-get upgrade
```

### Enable Swap

```bash
sudo dd if=/dev/zero of=/swap bs=1M count=1k
sudo chmod 0600 /swap
sudo mkswap /swap
sudo swapon /swap
sudo echo '/swap none swap sw 0 0' >> /etc/fstab
```

### Install prerequisites

```bash
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py --user
# Reconnect
pip install --user ansible
```

### Configure the Playbook

```bash
git clone https://github.com/spantaleev/matrix-docker-ansible-deploy.git
cd matrix-docker-ansible-deploy
mkdir inventory/host_vars/matrix.cumps.be
cp examples/host-vars.yml inventory/host_vars/matrix.cumps.be/vars.yml
cp examples/hosts inventory/hosts
nano inventory/hosts
nano inventory/host_vars/matrix.cumps.be/vars.yml
```

#### hosts

```
[matrix_servers]
matrix.cumps.be ansible_host=x.x.x.x ansible_ssh_user=ubuntu become=true become_user=root ansible_connection=local
```

#### vars.yml

```
matrix_domain: cumps.be

matrix_ssl_lets_encrypt_support_email: david@cumps.be

matrix_coturn_turn_static_auth_secret: "xxx"

matrix_synapse_macaroon_secret_key: "xxx"

matrix_coturn_turn_external_ip_address: "x.x.x.x"

matrix_riot_web_themes_enabled: true

matrix_nginx_proxy_proxy_matrix_nginx_status_enabled: true
matrix_nginx_proxy_proxy_matrix_nginx_status_allowed_addresses:
- x.x.x.x

matrix_s3_media_store_enabled: true
matrix_s3_media_store_bucket_name: "xxx"
matrix_s3_media_store_aws_access_key: "xxx"
matrix_s3_media_store_aws_secret_key: "xxxx"
matrix_s3_media_store_region: "eu-west-1"
```

### Run the Playbook

```bash
# you'll need to rerun setup-all and start tags again if you edit vars later
ansible-playbook -i inventory/hosts setup.yml --tags=setup-all
ansible-playbook -i inventory/hosts setup.yml --tags=start
ansible-playbook -i inventory/hosts setup.yml --tags=self-check
ansible-playbook -i inventory/hosts setup.yml --extra-vars='username=cumpsd password=xxx admin=yes' --tags=register-user
```

### Configure Identity

Copy `/.well-known/matrix/server` and `/.well-known/matrix/client` from the Matrix server (e.g. `matrix.cumps.be`) to your base domain's server (`cumps.be`). You can find these files on URLs like this: `https://matrix.example.com/.well-known/matrix/server` (same for `client`).

## Using

### Synapse

Check https://matrix.cumps.be

### Riot

Check https://riot.cumps.be

### Dimension

```bash
ansible-playbook -i inventory/hosts setup.yml --extra-vars='username=dimension password=xxx admin=no' --tags=register-user
```

Update `vars.yml`

```
matrix_dimension_enabled: true
matrix_dimension_admins:
  - "@cumpsd:{{ matrix_domain }}"
matrix_dimension_access_token: "xxx"
```

Apply changes:

```bash
ansible-playbook -i inventory/hosts setup.yml --tags=setup-all,start
```

### Shared Secret

Update `vars.yml`

```
matrix_synapse_ext_password_provider_shared_secret_auth_enabled: true
matrix_synapse_ext_password_provider_shared_secret_auth_shared_secret: xxx
```

Apply changes:

```bash
ansible-playbook -i inventory/hosts setup.yml --tags=setup-all,start
```

### Hangouts

Update `vars.yml`

```
matrix_mautrix_hangouts_enabled: true
```

Apply changes:

```bash
ansible-playbook -i inventory/hosts setup.yml --tags=setup-all,start
```

### WhatsApp

```
matrix_mautrix_whatsapp_enabled: true
```

Apply changes:

```bash
ansible-playbook -i inventory/hosts setup.yml --tags=setup-all,start
```

### Facebook

```
matrix_mautrix_facebook_enabled: true

matrix_synapse_configuration_extension_yaml: |
  enable_group_creation: true
  group_creation_prefix: "unofficial/"

matrix_mautrix_facebook_configuration_extension_yaml: |
  bridge:
    community_template: "unofficial/facebook_{localpart}={server}"
```

Apply changes:

```bash
ansible-playbook -i inventory/hosts setup.yml --tags=setup-all,start
```
