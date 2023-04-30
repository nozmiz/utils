#!/bin/bash

# -------------------------------------------
# Create ~/.myk8s file and edit ~/.profile
# to load it.
# -------------------------------------------
mkdir -p ~/.k8s-tools
cp utils ~/.k8s-tools/

grep -q "source ~/.k8s-tools/utils" ~/.profile
if [[ $? -ne 0 ]]; then
  cat << EOS >> ~/.profile

# Automatically added for .k8s-tools
source ~/.k8s-tools/utils
EOS
fi

source ~/.profile

# -------------------------------------------
# Install krew, kubectx, kubedns
# -------------------------------------------
if [[ ! -d ~/.krew/bin ]]; then
  echo "Install krew, kubectx, kubedns"

  # Copied from https://krew.sigs.k8s.io/docs/user-guide/setup/install/
  (
    set -x; cd "$(mktemp -d)" &&
    OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
    KREW="krew-${OS}_${ARCH}" &&
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
    tar zxvf "${KREW}.tar.gz" &&
    ./"${KREW}" install krew
  )

  kubectl krew install ctx
  kubectl krew install ns
fi


# -------------------------------------------
# Install other tools
# -------------------------------------------

# stern
kubectl krew install stern
