# Apply only a part of a module

```bash
cd basisregisters/root
terraform apply -var-file=../../../vbr-staging.tfvars -var-file=../../../vbr-staging.secret.tfvars \
  -target=module.road-registry.aws_route53_zone.road_zone \
  -target=module.road-registry.aws_route53_record.backoffice_ui \
  -target=module.road-registry.aws_route53_record.backoffice_api \
  -target=module.road-registry.aws_route53_record.public_backoffice_api \
  -target=module.road-registry.aws_route53_record.public_backoffice_ui \
  -target=module.road-registry.aws_s3_bucket.lb_access_logs \
  -target=module.road-registry.aws_s3_bucket_policy.lb_access_logs
```
