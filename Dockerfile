FROM python:2.7

COPY bundle /bundle
WORKDIR /bundle

RUN pip install -r requirements.txt || true

CMD python $BUNDLE_MAIN
