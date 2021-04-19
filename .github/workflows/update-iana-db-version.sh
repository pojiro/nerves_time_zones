#!/bin/sh
set -e



IANA_VERSION=$(wget -q -O - "https://data.iana.org/time-zones/tzdata-latest.tar.gz" | tar --to-stdout -xz version)
CURRENT_VERSION=$(awk '/@tzdata_version\\s/{print $NF}' mix.exs | sed -e 's/^"//' -e 's/"$//')

if [ "$CURRENT_VERSION" == "$IANA_VERSION" ]; then 
  echo "Versions are equal"
  exit 1
fi

sed -i "/@tzdata_version\s\"/c\  @tzdata_version \"$IANA_VERSION\"" mix.exs