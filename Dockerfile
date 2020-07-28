FROM nixos/nix

RUN apk add --no-cache \
	# Useful for debugging.
	bash \
	# Fix a timezone issue inside `nix-shell`, since nix-shell still depends on host timezone.
	tzdata

# Cache packages.
COPY default.nix .
RUN nix-shell --run exit
