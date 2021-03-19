import {r} from "./registry"
import {set} from "./core"

# TODO

# similar to divider, would be nice to support:
#    ring 2px 2px indigo-300
#
# also a scenario wwhere keyword arguments helps:
#    ring width: 2px offset: 2px indigo-300

# https://tailwindcss.com/docs/ring-width

# *	box-shadow: 0 0 #0000;
# ring-0	box-shadow: var(--tw-ring-inset) 0 0 0 calc(0px + var(--tw-ring-offset-width)) var(--tw-ring-color);
# ring-1	box-shadow: var(--tw-ring-inset) 0 0 0 calc(1px + var(--tw-ring-offset-width)) var(--tw-ring-color);
# ring-2	box-shadow: var(--tw-ring-inset) 0 0 0 calc(2px + var(--tw-ring-offset-width)) var(--tw-ring-color);
# ring-4	box-shadow: var(--tw-ring-inset) 0 0 0 calc(4px + var(--tw-ring-offset-width)) var(--tw-ring-color);
# ring-8	box-shadow: var(--tw-ring-inset) 0 0 0 calc(8px + var(--tw-ring-offset-width)) var(--tw-ring-color);
# ring	box-shadow: var(--tw-ring-inset) 0 0 0 calc(3px + var(--tw-ring-offset-width)) var(--tw-ring-color);
# ring-inset	--tw-ring-inset: inset;

# ring color, opacity, offset width, color
