FROM ubuntu:bionic

ENV PYTHONUNBUFFERED 1

RUN apt-get update
RUN apt-get install -y python-virtualenv
RUN apt-get install -y python3-pip
RUN apt-get install -y python3-dev
RUN apt-get install -y git
RUN apt-get install -y build-essential
RUN apt-get install -y liblilv-dev
RUN apt-get install -y libasound2-dev
RUN apt-get install -y libjack-dev

RUN virtualenv --python=python3 modui-env
RUN bash modui-env/bin/activate

COPY . .

RUN pip3 install -r requirements.txt

WORKDIR ./utils/
RUN make

WORKDIR ..
ENTRYPOINT ["python3", "./server.py"]
