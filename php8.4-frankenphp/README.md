# PHP 8.4 + FrankenPHP Docker Base Image

A production-ready Docker base image for **Laravel Octane** with:
- **PHP 8.4** (latest)
- **FrankenPHP** (latest from official `dunglas/frankenphp`)
- **MongoDB** extension
- All common Laravel extensions

## Included PHP Extensions

| Extension | Purpose |
|-----------|---------|
| `pdo`, `pdo_pgsql`, `pgsql` | PostgreSQL support |
| `pdo_mysql`, `mysqli` | MySQL support |
| `mongodb` | MongoDB support |
| `redis` | Redis cache/session |
| `zip` | ZIP file handling |
| `intl` | Internationalization |
| `mbstring` | Multibyte string |
| `bcmath` | Arbitrary precision math |
| `opcache` | PHP bytecode cache |
| `pcntl` | Process control (for Horizon) |
| `gd` | Image manipulation (with freetype, jpeg, webp) |
| `exif` | Image metadata |
| `imagick` | Advanced image processing |

## Build & Push

```bash
# Build the image
docker build -t thinktran/php8.4-frankenphp:latest .

# Push to Docker Hub
docker push thinktran/php8.4-frankenphp:latest
```

## Usage in Your Project

Replace in your `Dockerfile`:

```dockerfile
# Before
FROM kingdarkness/lumen-php:8.2-franken

# After
FROM thinktran/php8.4-frankenphp:latest
```

## PHP Configuration

### OPcache (Optimized for Production)
- Memory: 256MB
- Max files: 32531
- Interned strings buffer: 64MB
- Timestamps validation: disabled (for production)

### Upload Limits
- `upload_max_filesize`: 100M
- `post_max_size`: 100M
- `memory_limit`: 512M
- `max_execution_time`: 300s

## Notes

- Based on **Alpine Linux** for minimal image size
- Includes **Composer** pre-installed
- FrankenPHP binary is already included (no runtime download needed)
