FROM python:3.9

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    netcat-openbsd \
    rsync \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /app/
RUN pip install -r requirements.txt

COPY manage.py .
COPY gutendex/ ./gutendex/
COPY books/ ./books/
COPY static/ ./static/
COPY catalog_files/tmp/catalog.tar.bz2 ./catalog_files/tmp/catalog.tar.bz2

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]