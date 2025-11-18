# Use Kali rolling as base
FROM kalilinux/kali-rolling

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update, upgrade and install packages (includes ping, dig and net-tools)
RUN apt update && apt full-upgrade -y && \
    apt install -y --no-install-recommends \
      kali-linux-default \
      kali-tools-top10 \
      iputils-ping \
      dnsutils \        
      curl \
      wget \
      nano \
      vim \
      git \
      nmap \
      whois \
      traceroute \
      tcpdump \
      openssh-client \
      telnet \
    && apt clean && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
