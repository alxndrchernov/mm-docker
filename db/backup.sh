#!/bin/sh

pg_dump -h localhost -U mmuser -d mattermost > "/pg_backups/db_dump_$(date +"%Y%m%d%H%M%S").sql"
