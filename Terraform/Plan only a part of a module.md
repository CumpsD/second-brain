# Plan only a part of a module

```bash
cd basisregisters/root
terraform plan -var-file=../../../vbr-staging.tfvars -var-file=../../../vbr-staging.secret.tfvars \
  -target=module.organisation-registry.aws_route53_zone.wegwijs \
  -target=module.organisation-registry.aws_route53_record.organisation-ui-wegwijs \
  -target=module.organisation-registry.aws_route53_record.organisation-api-wegwijs \
  -target=module.organisation-registry.aws_route53_record.organisation-api \
  -target=module.organisation-registry.aws_route53_record.organisation-ui \
  -target=module.organisation-registry.aws_route53_record.projections-api
```
