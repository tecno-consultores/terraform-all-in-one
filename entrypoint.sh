#!/bin/bash
semaphore user add --admin --login admin --password 0n0qNwFTHSMdd6i2m0xxukAuuVluppKD --name "admin" --email "admin@localhost" --config /etc/semaphore/config.json || true
exec semaphore server --config /etc/semaphore/config.json
