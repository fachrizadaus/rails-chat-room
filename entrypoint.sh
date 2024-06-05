#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /rails/tmp/pids/server.pid

# Wait for PostgreSQL to be ready
until pg_isready -h $DATABASE_HOST -U $DATABASE_USER; do
  echo >&2 "Postgres is unavailable - sleeping"
  sleep 1
done

# Execute database migrations
bundle exec rails db:migrate

# Execute the container's main process (what's set as CMD in the Dockerfile).
exec "$@"