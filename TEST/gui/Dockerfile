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

ARG USER=user
RUN groupadd --gid 1000 $USER && \
    useradd --gid 1000 --uid 1000 --no-create-home --shell /bin/zsh $USER
#RUN echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER

WORKDIR /home/$USER
RUN chown 1000:1000 .
USER 1000:1000
ENV USER=$USER
ENV HOST=docker

RUN git clone https://github.com/akozlins/dotfiles .dotfiles
RUN bash -c ./.dotfiles/install.sh

#RUN git clone https://aur.archlinux.org/yay-bin.git
#RUN cd yay-bin && makepkg && makepkg -i --noconfirm
