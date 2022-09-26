# Relution

With the [Relution](https://relution.io) device management platform, mobile and stationary end devices can be conveniently managed via an intuitive interface. Wherever smartphones, tablets, laptops, computers, and interactive whiteboards are used. Digital devices can thus be configured, equipped and controlled quickly and easily.

## Installing

### Prerequisites
- Helm v3 [installed](https://helm.sh/docs/using_helm/#installing-helm)
- Relational database (ex. PostgreSQL/MariaDB) ready to use
- Optional: S3-compatible object storage ready to use

Add the chart repository to Helm:

```bash
helm repo add relution https://relution-io.github.io/relution-kubernetes/
helm repo update
```

### Customizing your values
```yaml
relution:
  config:
    relution:
      database:
        type: postgresql
        url: jdbc:postgresql://mycluster:5432/mydatabase
        username: <DATABASE_USER>
      orga:
        name: "My Organization"
  environment:
    STORAGE_TYPE: S3
    STORAGE_S3_ACCESS_KEY: <AWS_ACCESS_KEY_ID>
    STORAGE_S3_BUCKET_NAME: my-relution-resources-bucket
    STORAGE_S3_BUCKET_REGION: eu-central-1
  secrets:
    DATABASE_PWD: <DATABASE_PASSWORD>
    STORAGE_S3_SECRET_KEY: <S3_SECRET_KEY>

ingress:
  enabled: true
  hosts:
    - host: relution.mydomain.com
      paths:
        - path: /
          pathType: ImplementationSpecific
```

### Deploying Relution

```bash
helm install relution relution/relution -f my-values.yaml
```

## Contributing
Feel free to contribute to this chart by creating an [issue](https://github.com/relution-io/relution-kubernetes/issues/new) or a [pull request](https://github.com/relution-io/relution-kubernetes/pulls). Any support/bug reports/feature requests are welcome.
