FROM python:2.7

VOLUME ["/bundle"]

WORKDIR /bundle

CMD pip install -r requirements.txt > /dev/null && \
    python $BUNDLE_MAIN
