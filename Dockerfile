FROM archlinux:base-devel

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
    git \
    neovim \
    python \
    python-pynvim \
    nodejs \
    npm \
    ripgrep \
    fd \
    curl \
    wget \
    unzip \
    which \
    base-devel \
    cmake \
    && rm -rf /var/cache/pacman/pkg/*

ARG USERNAME=amy  
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN npm install -g neovim

USER $USERNAME
WORKDIR /home/$USERNAME

RUN mkdir -p /home/$USERNAME/.config/nvim \
    && mkdir -p /home/$USERNAME/.local/share/nvim/lazy

COPY --chown=$USERNAME:$USERNAME init.lua /home/$USERNAME/.config/nvim/
COPY --chown=$USERNAME:$USERNAME lua/ /home/$USERNAME/.config/nvim/lua/

RUN git clone --filter=blob:none --branch=stable \
    https://github.com/folke/lazy.nvim.git \
    /home/$USERNAME/.local/share/nvim/lazy/lazy.nvim

RUN ls -la /home/$USERNAME/.local/share/nvim/lazy || echo "Lazy directory not found"
RUN ls -la /home/$USERNAME/.config/nvim || echo "Nvim config directory not found"

RUN echo '#!/bin/bash' > /home/$USERNAME/docker-entrypoint.sh && \
    echo 'if [ -d "/home/$USERNAME/workspace" ]; then' >> /home/$USERNAME/docker-entrypoint.sh && \
    echo '    sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/workspace' >> /home/$USERNAME/docker-entrypoint.sh && \
    echo 'fi' >> /home/$USERNAME/docker-entrypoint.sh && \
    echo 'exec "$@"' >> /home/$USERNAME/docker-entrypoint.sh && \
    chmod +x /home/$USERNAME/docker-entrypoint.sh

ENTRYPOINT ["/home/amy/docker-entrypoint.sh"]
CMD ["nvim"]
