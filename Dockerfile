FROM ubuntu
RUN apt update
RUN apt upgrade -y
RUN apt install -y nodejs
RUN apt clean RUN rm -rf /var/lib/apt/lists/\*
