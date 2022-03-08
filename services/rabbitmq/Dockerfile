ARG RABBITMQ_VERSION
FROM rabbitmq:${RABBITMQ_VERSION}

ARG RABBITMQ_VERSION
ARG RABBITMQ_PLUGINS

ENV PLUGINS=",${RABBITMQ_PLUGINS},"

RUN if [ -z "${PLUGINS##*,rabbitmq_amqp1_0,*}" ]; then \
        printf "y\n"| rabbitmq-plugins enable rabbitmq_amqp1_0; \
    fi \
    && \
    if [ -z "${PLUGINS##*,rabbitmq_auth_backend_ldap,*}" ]; then \
        printf "y\n" | rabbitmq-plugins enable rabbitmq_auth_backend_ldap; \
    fi \
    && \
    if [ -z "${PLUGINS##*,rabbitmq_auth_backend_http,*}" ]; then \
        printf "y\n" | rabbitmq-plugins enable rabbitmq_auth_backend_http; \
    fi \
    && \
    if [ -z "${PLUGINS##*,rabbitmq_auth_mechanism_ssl,*}" ]; then \
        printf "y\n" | rabbitmq-plugins enable rabbitmq_auth_mechanism_ssl; \
    fi \
    && \
    if [ -z "${PLUGINS##*,rabbitmq_consistent_hash_exchange,*}" ]; then \
        printf "y\n" | rabbitmq-plugins enable rabbitmq_consistent_hash_exchange; \
    fi \
    && \
    if [ -z "${PLUGINS##*,rabbitmq_federation,*}" ]; then \
        printf "y\n" | rabbitmq-plugins enable rabbitmq_federation; \
    fi \
    && \
    if [ -z "${PLUGINS##*,rabbitmq_federation_management,*}" ]; then \
        printf "y\n" | rabbitmq-plugins enable rabbitmq_federation_management; \
    fi \
    && \
    if [ -z "${PLUGINS##*,rabbitmq_management_agent,*}" ]; then \
        printf "y\n" | rabbitmq-plugins enable rabbitmq_management_agent; \
    fi \
    && \
    if [ -z "${PLUGINS##*,rabbitmq_mqtt,*}" ]; then \
        printf "y\n" | rabbitmq-plugins enable rabbitmq_mqtt; \
    fi \
    && \
    if [ -z "${PLUGINS##*,rabbitmq_prometheus,*}" ]; then \
        printf "y\n" | rabbitmq-plugins enable rabbitmq_prometheus; \
    fi \
    && \
    if [ -z "${PLUGINS##*,rabbitmq_shovel,*}" ]; then \
        printf "y\n" | rabbitmq-plugins enable rabbitmq_shovel; \
    fi \
    && \
    if [ -z "${PLUGINS##*,rabbitmq_shovel_management,*}" ]; then \
        printf "y\n" | rabbitmq-plugins enable rabbitmq_shovel_management; \
    fi \
    && \
    if [ -z "${PLUGINS##*,rabbitmq_stomp,*}" ]; then \
        printf "y\n" | rabbitmq-plugins enable rabbitmq_stomp; \
    fi \
    && \
    if [ -z "${PLUGINS##*,rabbitmq_trust_store,*}" ]; then \
        printf "y\n" | rabbitmq-plugins enable rabbitmq_trust_store; \
    fi \
    && \
    if [ -z "${PLUGINS##*,rabbitmq_web_stomp,*}" ]; then \
        printf "y\n" | rabbitmq-plugins enable rabbitmq_web_stomp; \
    fi \
    && \
    if [ -z "${PLUGINS##*,rabbitmq_web_mqtt,*}" ]; then \
        printf "y\n" | rabbitmq-plugins enable rabbitmq_web_mqtt; \
    fi \
    && \
    if [ -z "${PLUGINS##*,rabbitmq_web_stomp_examples,*}" ]; then \
        printf "y\n" | rabbitmq-plugins enable rabbitmq_web_stomp_examples; \
    fi \
    && \
    if [ -z "${PLUGINS##*,rabbitmq_web_mqtt_examples,*}" ]; then \
        printf "y\n" | rabbitmq-plugins enable rabbitmq_web_mqtt_examples; \
    fi \
    && \
    if [ -z "${PLUGINS##*,rabbitmq_delayed_message_exchange,*}" ]; then \
        printf "y\n" | rabbitmq-plugins enable rabbitmq_delayed_message_exchange; \
    fi 
