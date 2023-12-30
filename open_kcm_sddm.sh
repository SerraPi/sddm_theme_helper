#!/bin/bash

# Works with other kcms too > systemsettings5 --list
CONTROL_PANEL_ITEM="kcm_sddm"

# kill any open systemsettings so that ours opens on top
pkill -15 systemsettings

systemsettings5 $CONTROL_PANEL_ITEM
