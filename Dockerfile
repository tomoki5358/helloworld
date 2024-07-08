FROM python:3.9-slim-buster

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir --upgrade -r requirements.txt

COPY . .

ENV MESSAGE="Hello from environment variable!"

CMD ["python", "app.py"]
