FROM nixos/nix

# Cache packages.
COPY default.nix .
RUN nix-shell --pure --run exit

# Smoke test
RUN nix-shell --pure --run "julia -e 'using Pkg; Pkg.build(\"RCall\"); using RCall; R\"library(ggplot2)\"'"

RUN apk add --no-cache \
	# Useful for debugging.
	bash \
	# Fix a timezone issue inside `nix-shell`, since nix-shell still depends on host timezone.
	tzdata
