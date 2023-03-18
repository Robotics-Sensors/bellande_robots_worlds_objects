import sys, os

from file_reroute.reroute import reroute
reroute(["ML_pointcloud_object_detection"])
from header_imports import *

class pointcloud_object_detection_client(grpc_server_connection):
    def __init__(self):
        grpc_server_connection.__init__(self)
        
        self.stub = service.ClientStub(self.channel)

    def create_client(self, project_id):
        client = message.Client(project_id=project_id)
        req = message.ClientReq(client=client)
        return self.stub.CreateClient(req)

    def get_model(self, project_id):
        req = message.ProjectIdReq(project_id=project_id)
        return self.stub.MakePremium(req)

    def get_dataset(self, project_id):
        req = message.ProjectIdReq(project_id=project_id)
        return self.stub.DeleteUser(req)

    def import_model(self, project_id):
        req = message.ProjectIdReq()
        return self.stub.checkPremium(req)

    def import_dataset(self, project_id):
        req = message.ProjectIdReq()
        return self.stub.checkPremium(req)

if __name__ == '__main__':
    robots_service_demo_obj = Robots_Service_Demo()

