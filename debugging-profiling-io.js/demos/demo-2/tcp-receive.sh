#!/usr/bin/env bash

sudo dtrace -n 'tcp:::receive { @[args[2]->ip_saddr] = count(); }'
