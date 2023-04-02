FROM nginx/unit:1.29.1-python3.11

COPY requirements.txt /app/requirements.txt

RUN apt update && apt install -y python3-pip \
    && pip3 install -r /app/requirements.txt \
    && apt remove -y python3-pip             \
    && apt autoremove --purge -y             \
    && rm -rf /var/lib/apt/lists/* /etc/apt/source.list.d/*.list