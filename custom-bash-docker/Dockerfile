FROM public.ecr.aws/lambda/provided:al2023

ENV HANDLER="function.handler"

COPY ./bootstrap  ${LAMBDA_TASK_ROOT}/bootstrap
COPY ./function.sh  ${LAMBDA_TASK_ROOT}/function.sh

RUN chmod +x ${LAMBDA_TASK_ROOT}/bootstrap
RUN chmod +x ${LAMBDA_TASK_ROOT}/function.sh


ENTRYPOINT ["/var/task/bootstrap"]
