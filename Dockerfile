FROM nixos/nix

RUN apk add --no-cache \
	# Useful for debugging.
	bash \
	# Fix a timezone issue inside `nix-shell`, since nix-shell still depends on host timezone.
	tzdata

# Cache packages.
COPY default.nix .
RUN nix-shell --pure --run exit

# Smoke test
# This can only be ran if using `docker buildx build --allow security.insecure`.
# RUN nix-shell --run "julia -e 'using Pkg; Pkg.add(\"RCall\"); Pkg.build(\"RCall\"); using RCall; R\"library(ggplot2)\"'"

