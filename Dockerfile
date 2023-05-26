FROM python:3.11-alpine3.17 as builder

RUN python3 -m venv /app
RUN /app/bin/pip install -U pip

COPY requirements.txt /mnt/
RUN /app/bin/pip install -Ur /mnt/requirements.txt

FROM python:3.11-alpine3.17 as app

WORKDIR /app

COPY --from=builder /app /app
COPY ./app ./app

EXPOSE 8080

CMD /app/bin/uvicorn app.main:app --host=0.0.0.0 --port 8080
