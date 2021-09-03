FROM python:3.9.0

WORKDIR /home/

RUN git clone https://github.com/chaejinims2/gis_4ban_1.git

WORKDIR /home/gis_4ban_1

RUN echo "SECRET_KEY=django-insecure-#&p0yux4f1@bzsy$#1rijpzc^m-%rp*i-59lji0-*sjjy69eg^"

RUN pip install -r requirements.txt

RUN python manage.py migrate

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]