FROM ubuntu:22.04
LABEL authors.maintainer="contribuidores edk: https://github.com/keepchasingheaven/encore-development-kit/-/graphs/main"

## o script ci que constrói esse arquivo pode ser encontrado
## em: support/docker

ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV EDK_DEBUG=true

## https://gitlab.com/gitlab-org/gitlab-development-kit/-/issues/2807
ARG mise_http_timeout=60s
ENV MISE_HTTP_TIMEOUT $mise_http_timeout

ARG mise_fetch_remote_versions_timeout=60s
ENV MISE_FETCH_REMOTE_VERSIONS_TIMEOUT $mise_fetch_remote_versions_timeout

ARG mise_http_retries=2
ENV MISE_HTTP_RETRIES=$mise_http_retries

RUN apt-get update && \
	apt-get install -y \
		curl \
		libssl-dev \
		locales \
		locales-all \
		pkg-config \
		software-properties-common \
		sudo && \
	add-apt-repository ppa:git-core/ppa -y

RUN useradd --user-group --create-home --groups sudo edk && \
	echo "edk ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/edk_no_password

WORKDIR /home/edk/tmp
RUN chown -R edk:edk /home/edk

USER edk
COPY --chown=edk . .

ENV PATH="/home/gdk/.local/bin:/home/gdk/.local/share/mise/bin:/home/gdk/.local/share/mise/shims:${PATH}"

SHELL ["/bin/bash", "-c"]
RUN echo "tool_version_manager:" > edk.yml && \
	echo "  enabled: true" >> edk.yml && \
	bash ./support/bootstrap && \
	echo 'verificar ferramentas e limpeza...' && \
	eval "$(mise activate --shims)" && \
	bash -eclx "versão mise; yarn --version; node --version; ruby --version" && \
	sudo apt-get purge software-properties-common -y && \
	sudo apt-get clean -y && \
	sudo apt-get autoremove -y && \
	sudo rm -rf \
		"$HOME/.cache/" \
		"$HOME/tmp" \
		/tmp/* \
		/var/cache/apt/* \
		/var/lib/apt/lists/* \
		$(ls -d "$HOME/edk/gitaly/_build/"* | grep -v /bin) \
		$HOME/.rustup/toolchains/*/share/doc/rust/html && \
	sudo find $HOME/.local/share/mise/installs/ruby/*/lib/ruby/gems/*/gems/lefthook*/libexec/ -type f -and -not -path '*-linux-*' -delete

WORKDIR /home/edk
