import sys, os

from file_reroute.reroute import reroute
reroute(["ML_pointcloud_object_detection"])
from header_imports import *


class grpc_server_connection(configs):
    def __init__(self):
        configs.__init__(self)
        self.host = self.config["grpc_client"]["host"]
        self.port = self.config["grpc_client"]["port"]
        self.channel = grpc.insecure_channel('{}:{}'.format(self.host, self.port))

        try:
            grpc.channel_ready_future(self.channel).result(timeout=10)
            print("Connected to Grpc Server")
        except grpc.FutureTimeoutError:
            sys.exit('Error connecting to server')


if __name__ == "__main__":
    grpc_server_connection_obj = grpc_server_connection()
