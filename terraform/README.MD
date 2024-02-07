Infrastructure as code

what is solves - Infra team - field enginner, ssytem admin, storage adming, abckup admin, applicaition team.

<block> <paramter > { 

arguments 

}

Paramater - resource type and  resouce name
-----------------------------------

}

  block   resource_type  resource_name    
resource  "local_file" "meri_file" {

        filename = hello.txt
        content = "this is auto"

}



--------

TERRAFORM advanced concepts


state
remote backend
modules -> pre built modules and user defined modules


terraform info
Resouce -> ec2, s3 and db

terraform keeps state file , paritcular unique id has attributes, maintains state with help of object. 
makes object -> key value pair 
terraform state list


state file don't commit in local or git repo.

store in s3 bucket -< dynano db (any updated entry in db - lockid) is generated ) 
no one can update state file. after state file write lock id gets dfeleted.



create VPC 
1) modeule -> cidr, submets, NAT using moduels. 

module_vpc.tf, main.tf 


Infra.tf

Google aws terraform . 
Resource "aws"

Install aws cli 


Amamazon machine image - ami 

 resource ami , instance type, tags, anem 


Resource "aws _vpc" "my_vpc {
    cidr_block = "182.0.0.0/16"
Tags = {
 name = "tf_example"
}

}

^
Block resource_type, resource name [

Arguments }



Var. = keyword toa access variable from variable block 


Arguments vs attribute 
When resource is created then you get attribute, before resource is created then you have to give arguments

Interpolation, how to create infra using best practices.





Output block shows output
Respurce block
Variable block
Terraform block
Providers


Module "dev_k8s" {


}


Reusual modules 

Disavle_on_destru = false 



Terraform 
   state, remote backend, modules, pre built and user defined 



Resource 
 ec2, s3 and dyanamo db

Resource type and name 

Terraform maintains state and identifies in a different manner 

Terraform knows by ID and attributes 


Maintain state by object
Any attribute, key value pair creates object. 


# terraform state list
# terraform state show 

Keeps in track and maintains



