* Checkout the project 

* git clone git@github.com:sivaramkannan/blockchain-platform.git
* cd blockchain-platform/ansible/playbooks
* Create a new file called params.yaml withe the below contents
```
---
monitoring:
  smtp_endpoint:
  smtp_email: "<email_id>"
  smtp_email_password: "<email_id_password>"

  storageclass_name: "default"
  storagesize: "10G"

loki:
  storageclass_name: "default"
  storagesize: "10G"
```
The storageclassname above should be one of the existing storageclass name in Azure/DO/AWS and the smtp_email and smtp_email_password should be the email id and password of the account from which the monitoring alerts would be sent.
* Deploy the components
```
ansible-playbook deploy.yaml -e 'ansible_python_interpreter=/usr/local/bin/python3' --extra-vars @params.yaml
```
* To uninstall the components
```
ansible-playbook uninstall.yaml -e 'ansible_python_interpreter=/usr/local/bin/python3' --extra-vars @params.yaml
```
