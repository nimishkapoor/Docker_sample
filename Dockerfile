FROM ubuntu:16.04

RUN dpkg --add-architecture i386
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y socat build-essential libc6:i386 libncurses5:i386 libstdc++6:i386

#adduser
RUN adduser --disabled-password --gecos '' useafterfree

#securityRestrictions
RUN chown -R root:useafterfree /home/useafterfree/
RUN chmod 750 /home/useafterfree
RUN chmod 740 /usr/bin/top
RUN chmod 740 /bin/ps
RUN chmod 740 /usr/bin/pgrep
RUN export TERM=xterm

WORKDIR /home/useafterfree

COPY src/useafterfree /home/useafterfree
COPY src/flag.txt /home/useafterfree

RUN chown root:useafterfree /home/useafterfree/flag.txt
RUN chmod 440 /home/useafterfree/flag.txt

EXPOSE 31336
CMD su useafterfree -c "socat -T10 TCP-LISTEN:31336,reuseaddr,fork EXEC:/home/useafterfree/useafterfree"
