FROM asami76/hadoop-pseudo:v1.0

ENV HOSTNAME hadoopc

COPY start-hadoop.sh /usr/local/hadoop/sbin/start-hadoop.sh
RUN chmod +x /usr/local/hadoop/sbin/start-hadoop.sh



ENTRYPOINT ["/usr/local/bootstrap.sh"]
CMD ["bash"]


