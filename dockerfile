FROM python:3.9

ENV PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    netcat-openbsd \
    rsync \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /app/
RUN pip install -r requirements.txt

COPY manage.py /app/
COPY gutendex /app/gutendex/
COPY books /app/books/
COPY static /app/static/
COPY catalog_files/tmp/catalog.tar.bz2 /app/catalog_files/tmp/catalog.tar.bz2


COPY entrypoint.sh /app/
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]