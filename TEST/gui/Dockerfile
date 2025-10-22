#

FROM archlinux

# init
RUN pacman-key --init && \
    pacman -Sy --noconfirm archlinux-keyring && \
    pacman -Syu --noconfirm

# packages
RUN pacman -S --noconfirm \
    base-devel git nano zsh \
    gedit

# cleanup
RUN pacman -Scc --noconfirm

RUN groupadd --gid 1000 user && \
    useradd --gid 1000 --uid 1000 --shell /bin/zsh user
RUN echo "user ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/user

WORKDIR /home/user
RUN chown 1000:1000 .
USER 1000:1000

RUN git clone https://github.com/akozlins/dotfiles .dotfiles
RUN ln -s .dotfiles/.profile
RUN ln -s .dotfiles/.zshrc

RUN git clone https://aur.archlinux.org/yay-bin.git
RUN cd yay-bin && makepkg && makepkg -i --noconfirm
