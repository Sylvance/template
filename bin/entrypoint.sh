#!/bin/bash
set -e

case "$1" in
"server")
  shift
  exec bundle exec puma -C config/puma.rb "$@"
  ;;
"sidekiq")
  shift
  exec bundle exec sidekiq  "$@"
  ;;
"migrate")
  exec bundle exec rake db:create
  exec bundle exec rake db:seed
  exec bundle exec rake db:migrate
  ;;
*)
  exec "$@"
  ;;
esac
