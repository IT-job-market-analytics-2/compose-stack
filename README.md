# compose-stack

Запуск проекта

``
docker-compose up --build -d
``

RabbitMQ доступен по 

``
http://localhost:15672/
``

Вход в Mongosh

``
docker exec -it it-job-vacancies-db-mongo mongosh -u analytics_service -p password --authenticationDatabase vacancies_db
``