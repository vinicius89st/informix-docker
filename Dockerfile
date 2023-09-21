FROM vinicius89stna/informix-db:latest
RUN apt-get install dos2unix -y
RUN echo 'root:I1n2f3o4' | chpasswd
RUN groupadd informix
RUN useradd -g informix -d /home/informix -m informix
RUN echo 'informix:I1n2f3o4' | chpasswd

COPY .bashrc /home/informix/.bashrc

COPY * /home/informix/
RUN mv /home/folder/* /home/informix
RUN chown informix.informix /home/informix/*
RUN mkdir /home/informix/explorit
RUN chown informix.informix -R /home/informix/explorit
RUN chmod 770 -R /home/informix/explorit


RUN echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# EXPOSE 9088

CMD /bin/bash /home/informix/install.sh ; su informix -c "/bin/bash /home/informix/start.sh" ; su informix -c "/bin/bash" ; su informix -c"/bin/bash /home/informix/stop.sh"