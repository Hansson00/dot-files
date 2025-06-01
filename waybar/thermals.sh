#!/bin/bash
echo $(sensors | grep Package | grep -oP '\d+\.\d+°C' | head -n 1)
