FROM docker.io/python:3.12

WORKDIR /

# --- [Install python and pip] ---
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y python3 python3-pip git
COPY . /

RUN pip install --no-cache-dir -r requirements.txt
RUN pip install gunicorn

ENV GUNICORN_CMD_ARGS="--workers=3 --bind=0.0.0.0:3168"

EXPOSE 3168

# Define environment variable
ENV FLASK_ENV=deployed

CMD [ "gunicorn", "main:app" ]
