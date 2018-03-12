## Learning Chef

### Infrastructure Automation
Track: https://learn.chef.io/tracks/infrastructure-automation/

#### Learn the Chef basics

Folder: 1_learn_the_basics

Course: https://learn.chef.io/tutorials/learn-the-basics/

How to play locally:

```
$ curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk -c stable -v 0.18.30
$ cd 1_learn_the_basics
$ sudo chef-client --local-mode hello.rb
$ sudo chef-client --local-mode goodbye.rb
$ sudo chef-client --local-mode webserver.rb
$ sudo chef-client --local-mode webserver-disable.rb
$ sudo chef-client --local-mode --runlist 'recipe[learn_chef_httpd]'
```

#### Manage a node with Chef server

Folder: 2_manage_a_node

Course: https://learn.chef.io/modules/manage-a-node-chef-server/

Course study log: https://github.com/ygorth/learning-chef/blob/master/study_logs_pdfs/2_manage_a_node.pdf

#### Get started with Test Kitchen with CentOS on Microsoft Azure

Folder: 3_test_kitchen_centOS_azure

Course: https://learn.chef.io/modules/local-development/rhel/azure/

Course study log: https://github.com/ygorth/learning-chef/blob/master/study_logs_pdfs/3_test_kitchen_centOS_azure.pdf

Create Azure Test Environment (Chef Workstation):

```
$ chef gem install kitchen-azurerm
$ sudo yum install python-devel
$ sudo curl -L https://aka.ms/InstallAzureCli | bash
$ az --version
$ az login
$ az app list
 
# Create the service principal
$ az ad sp create-for-rbac --name "my-chef-kitchen-test" --password "strong password"
{
  "appId": "8409b0f7-xxxx-xxxx-881e-72dc5f38f9ca",
  "displayName": "my-chef-kitchen-test",
  "name": "http://my-chef-kitchen-test",
  "password": "XXXXXX",
  "tenant": "5bbd0f75-xxxx-xxxx-a6e1-8a9645889f05"
}
 
# Get information about the service principal.
$ az ad sp show --id 8409b0f7-xxxx-xxxx-881e-72dc5f38f9ca
$ az app list

# Make sure you save the file with UTF-8 encoding!
$ vi ~/.azure/credentials
[abcd1234-YOUR-SUBSCRIPTION-ID-HERE-abcdef123456]
client_id = "8409b0f7-xxxx-xxxx-881e-72dc5f38f9ca"     ---- application id from the application step  
client_secret = "your-password"                        ---- password you supplied in the command line.
tenant_id = "9c117323-YOUR-GUID-HERE-9ee430723ba3"
 
$ chmod 600 ~/.azure/credentials
```

Provision an Azure virtual machine, deploy the cookbook, and execute the tests.
```
# Update this file with your information.
$ vi .kitchen.yml
$ cd cookbooks/learn_chef_httpd
$ kitchen list
Instance           Driver   Provisioner  Verifier  Transport  Last Action    Last Error
default-centos-72  Azurerm  ChefZero     Inspec    Ssh        <Not Created>  <None>
 
# Create the instance. 
$ kitchen create
$ kitchen list
Instance           Driver   Provisioner  Verifier  Transport  Last Action  Last Error
default-centos-72  Azurerm  ChefZero     Inspec    Ssh        Created      <None>
 
# Apply the cookbook to the machine.
$ kitchen converge
...
       Running handlers complete
       Chef Client finished, 4/4 resources updated in 13 seconds
       Finished converging <default-centos-72> (0m33.51s).
-----> Kitchen is finished. (0m34.51s)
$ kitchen list
Instance           Driver   Provisioner  Verifier  Transport  Last Action  Last Error
default-centos-72  Azurerm  ChefZero     Inspec    Ssh        Converged    <None>

# Verify the contents of your web server's home page.
$ kitchen exec -c 'curl localhost'
$ kitchen exec -c 'stat /var/www/html/index.html'
$ kitchen destroy
```
