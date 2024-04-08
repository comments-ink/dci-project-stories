FROM python:3.11.9-slim-bookworm AS compile-image

ENV PYTHONUNBUFFERED 1

RUN apt-get update
RUN apt-get install -y --no-install-recommends build-essential gcc libpq5 libpq-dev

ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv ${VIRTUAL_ENV}
ENV PATH="${VIRTUAL_ENV}/bin:$PATH"

WORKDIR /dci-project-stories
RUN pip install -U pip

COPY . .
RUN pip install -r requirements-docker.txt


FROM python:3.11.9-slim-bookworm AS build-image

RUN apt-get update
RUN apt-get install -y --no-install-recommends libpq5 wget

COPY --from=compile-image /opt/venv /opt/venv
COPY --from=compile-image /dci-project-stories /dci-project-stories
ENV PATH="/opt/venv/bin:$PATH"

RUN /dci-project-stories/scripts/setup-as-non-root.sh

WORKDIR /dci-project-stories/project_stories

USER gunicorn

EXPOSE 8000

CMD ["/dci-project-stories/scripts/wait-for-postgres.sh", "/dci-project-stories/scripts/run-gunicorn.sh"]
