function response = service_func_test(~, reqMsg, response)
%SERVICE_FUNC_TEST testing the service with ROS indigo in docker container
  % input:
    % `first`:  is the associated service server object.
    % `second`: is the request message object sent by the service client.
    % `third`:  is the default response message object.
  % output:
    % `response`: 
      % message based on the input request and sends it back to the client
      
% REMARK: the arguments of the request/response can be different from ROS
% i.e: 
% ----ROS -------- MATLAB ----
%   ack      -->   Ack
%   command  -->   Command
%   ee_name  -->   EeName
      
disp('I received a message!!!')
disp(' ')
disp('This is some of the content of the message:')
reqMsg.Command
reqMsg.EeName
disp(' ')

response.Ack = true;

end

