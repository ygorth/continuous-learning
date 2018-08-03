# It is just a test
FROM ubuntu
RUN apt-get update

ADD files* /mydir1/
ADD test /test2/

WORKDIR /path

USER ygorth

WORKDIR /path/to

WORKDIR workdir

CMD "echo" "Hello docker!"

ENTRYPOINT echo

ONBUILD ADD . /app/src
ONBUILD RUN /usr/local/bin/python-build --dir /app/src

EXPOSE 8080

ENV NAME_FOR_FILE bob
ENV SERVER_NO 4
ENV NEW_NAME_FILE "bob and others"

ENV NEW_WORK_DIR /folder1
WORKDIR ${new_work_dir}
WORKDIR $new_work_dir

ENV abc=hello
ENV abc=bye def=$abc
ENV ghi=abc

