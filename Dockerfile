FROM nixos/nix

# Cache packages.
COPY default.nix .
RUN nix-shell --pure --run exit

RUN apk add --no-cache \
	# Useful for debugging.
	bash \
	# Fix a timezone issue inside `nix-shell`, since nix-shell still depends on host timezone.
	tzdata

# Required for the next step.
# RUN sysctl kernel.unprivileged_userns_clone=1
# RUN sysctl kernel.grsecurity.chroot_deny_chmod=0
# RUN sysctl kernel.grsecurity.chroot_deny_mknod=0
RUN echo 1 > /proc/sys/kernel/unprivileged_userns_clone
# USER guest

# Smoke test
RUN nix-shell --run "julia -e 'using Pkg; Pkg.build(\"RCall\"); using RCall; R\"library(ggplot2)\"'"

