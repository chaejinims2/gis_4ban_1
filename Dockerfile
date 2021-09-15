FROM python:3.9.0

WORKDIR /home/

# 명령어가 하나하나 생성될 때마다 도커는 캐시이미지를 만들어냄..
# 명령어 하나하나 빌드 시간이 소모됨,
# 특정 명령어에서 에러가 뜨면 기존 빌드 내용을 리빌드 할 수 없기에 캐시 이미지를 사용함.
# 그러나 깃 클론이라는 명령어가 문제가 됨.

# 아무리 새로운 소스코드를 올리더라도 도커는 기존의 소스코드에 문제가 없다고 판단하여 깃클론을 리빌드하지 않는다.
# 이 때문에 의미없는 구문인 echo를 넣어주는 것
RUN echo 'sglsgsgsfsfg'

RUN git clone https://github.com/chaejinims2/gis_4ban_1.git

WORKDIR /home/gis_4ban_1

RUN echo "SECRET_KEY=django-insecure-#&p0yux4f1@bzsy$#1rijpzc^m-%rp*i-59lji0-*sjjy69eg^"

RUN pip install -r requirements.txt

RUN pip install gunicorn

RUN pip install mysqlclient

#RUN python manage.py migrate --settings=djangoProject.settings.deploy
#
#RUN python manage.py collectstatic --settings=djangoProject.settings.deploy

EXPOSE 8000

CMD ["bash", "-c", "python manage.py collectstatic --noinput --settings=djangoProject.settings.deploy && python manage.py migrate --settings=djangoProject.settings.deploy && gunicorn --env DJANGO_SETTINGS_MODULE=djangoProject.settings.deploy djangoProject.wsgi --bind 0.0.0.0:8000"]