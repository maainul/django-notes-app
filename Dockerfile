# FROM python:3.9

# WORKDIR /app/backend

# COPY requirements.txt /app/backend
# RUN apt-get update \
#     && apt-get upgrade -y \
#     && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
#     && rm -rf /var/lib/apt/lists/*


# Install app dependencies
# RUN pip install mysqlclient
# RUN pip install --no-cache-dir -r requirements.txt

# COPY . /app/backend

# EXPOSE 8000
#RUN python manage.py migrate
#RUN python manage.py makemigrations
FROM python:3.9

WORKDIR /app/backend

# Copy and install dependencies
COPY requirements.txt /app/backend
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . /app/backend

# Expose the application port
EXPOSE 8000

# Start the application
CMD ["sh", "-c", "python3 manage.py migrate && python3 manage.py runserver 0.0.0.0:8000"]
