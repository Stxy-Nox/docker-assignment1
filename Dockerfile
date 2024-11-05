FROM mongo
copy /seeding.json /data/seeding.json
ADD /start.sh /data/start.sh
RUN chmod +x /data/start.sh
CMD [ "/data/start.sh" ]