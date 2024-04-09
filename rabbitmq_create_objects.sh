function create_queue {
    curl --request PUT \
    --url "http://localhost:15672/api/queues/%2F/$1" \
    --header 'Authorization: Basic YW5hbHl0aWNzX3NlcnZpY2U6cGFzc3dvcmQ=' \
    --data-raw '{
        "auto_delete": false,
        "durable": true,
        "arguments": {}
    }'
}

function create_exchange {
    curl --request PUT \
    --url "http://localhost:15672/api/exchanges/%2F/$1" \
    --header 'Authorization: Basic YW5hbHl0aWNzX3NlcnZpY2U6cGFzc3dvcmQ=' \
    --data-raw "{
        \"type\": \"$2\",
        \"auto_delete\": false,
        \"durable\": true,
        \"arguments\": {}
    }"
}

function create_binding {
    curl --request POST \
    --url "http://localhost:15672/api/bindings/%2F/e/$1/q/$2" \
    --header 'Authorization: Basic YW5hbHl0aWNzX3NlcnZpY2U6cGFzc3dvcmQ=' \
    --data-raw "{
        \"routing_key\": \"$3\",
        \"arguments\": {}
    }"
}

# Scheduler service exchange
create_exchange scheduled-tasks-exchange direct

# Vacancy import service task consumer
create_queue vacancy-import-scheduled-tasks-queue
create_binding scheduled-tasks-exchange vacancy-import-scheduled-tasks-queue vacancy-import-task

# Analytics builder service task consumer
create_queue analytics-builder-scheduled-tasks-queue
create_binding scheduled-tasks-exchange analytics-builder-scheduled-tasks-queue analytics-builder-task

create_queue scheduled-tasks-queue
create_queue imported-vacancies-queue
create_queue new-vacancies-queue
create_queue telegram-notifications-queue