FROM nixos/nix

# Cache packages.
COPY default.nix .
RUN nix-shell --pure --run exit

RUN apk add --no-cache \
	# Useful for debugging.
	bash \
	# Fix a timezone issue since nix-shell still depends on host timezone.
	tzdata
