FROM python:3.9-slim

WORKDIR /app
COPY app.py /app/

RUN pip install flask kubernetes

EXPOSE 5000
CMD ["python", "app.py"]
