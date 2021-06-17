<!-- This file was automatically generated by the `geine`. Make all changes to `README.yaml` and run `make readme` to rebuild this file. -->

<p align="center"> <img src="https://user-images.githubusercontent.com/50652676/62349836-882fef80-b51e-11e9-99e3-7b974309c7e3.png" width="100" height="100"></p>


<h1 align="center">
    Terraform AWS S3
</h1>

<p align="center" style="font-size: 1.2rem;"> 
    Terraform module to create default S3 bucket with logging and encryption type specific features.
     </p>

<p align="center">

<a href="https://www.terraform.io">
  <img src="https://img.shields.io/badge/Terraform-v0.15-green" alt="Terraform">
</a>
<a href="LICENSE.md">
  <img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="Licence">
</a>


</p>
<p align="center">

<a href='https://facebook.com/sharer/sharer.php?u=https://github.com/clouddrove/terraform-aws-s3'>
  <img title="Share on Facebook" src="https://user-images.githubusercontent.com/50652676/62817743-4f64cb80-bb59-11e9-90c7-b057252ded50.png" />
</a>
<a href='https://www.linkedin.com/shareArticle?mini=true&title=Terraform+AWS+S3&url=https://github.com/clouddrove/terraform-aws-s3'>
  <img title="Share on LinkedIn" src="https://user-images.githubusercontent.com/50652676/62817742-4e339e80-bb59-11e9-87b9-a1f68cae1049.png" />
</a>
<a href='https://twitter.com/intent/tweet/?text=Terraform+AWS+S3&url=https://github.com/clouddrove/terraform-aws-s3'>
  <img title="Share on Twitter" src="https://user-images.githubusercontent.com/50652676/62817740-4c69db00-bb59-11e9-8a79-3580fbbf6d5c.png" />
</a>

</p>
<hr>


We eat, drink, sleep and most importantly love **DevOps**. We are working towards strategies for standardizing architecture while ensuring security for the infrastructure. We are strong believer of the philosophy <b>Bigger problems are always solved by breaking them into smaller manageable problems</b>. Resonating with microservices architecture, it is considered best-practice to run database, cluster, storage in smaller <b>connected yet manageable pieces</b> within the infrastructure. 

This module is basically combination of [Terraform open source](https://www.terraform.io/) and includes automatation tests and examples. It also helps to create and improve your infrastructure with minimalistic code instead of maintaining the whole infrastructure code yourself.

We have [*fifty plus terraform modules*][terraform_modules]. A few of them are comepleted and are available for open source usage while a few others are in progress.




## Prerequisites

This module has a few dependencies: 

- [Terraform 0.13](https://learn.hashicorp.com/terraform/getting-started/install.html)
- [Go](https://golang.org/doc/install)
- [github.com/stretchr/testify/assert](https://github.com/stretchr/testify)
- [github.com/gruntwork-io/terratest/modules/terraform](https://github.com/gruntwork-io/terratest)







## Examples


**IMPORTANT:** Since the `master` branch used in `source` varies based on new modifications, we suggest that you use the release versions [here](https://github.com/clouddrove/terraform-aws-s3/releases).


Here are some examples of how you can use this module in your inventory structure:
### Basic Bucket
```hcl
module "s3_bucket" {
  source              = "clouddrove/s3/aws"
  version             = "0.15.0"
  name                = "clouddrove-secure-bucket"
  environment         = "test"
  label_order         = ["name", "environment"]
  versioning          = true
  acl                 = "private"
  bucket_enabled      = true
}
```
### Encryption Bucket
```hcl
module "s3_bucket" {
  source                     = "clouddrove/s3/aws"
  version                    = "0.15.0"
  name                       = "clouddrove-encryption-bucket"
  environment                = "test"
  label_order                = ["name", "environment"]
  versioning                 = true
  acl                        = "private"
  bucket_encryption_enabled  = true
  sse_algorithm              = "aws:kms"
  kms_master_key_id          = module.kms_key.key_arn
}
### Logging-Encryption Bucket
```hcl
module "s3_bucket" {
  source                             = "clouddrove/s3/aws"
  version                            = "0.15.0"
  name                               = "clouddrove-logging-encryption-bucket"
  environment                        = "test"
  label_order                        = ["name", "environment"]
  versioning                         = true
  acl                                = "private"
  bucket_logging_encryption_enabled  = true
  sse_algorithm                      = "AES256"
  target_bucket                      = "bucket-logs12"
  target_prefix                      = "logs"
}
```
### Logging Bucket
```hcl
module "s3_bucket" {
  source                  = "clouddrove/s3/aws"
  version                 = "0.15.0"
  name                    = "clouddrove-logging-bucket"
  environment             = "test"
  label_order             = ["name", "environment"]
  versioning              = true
  acl                     = "private"
  bucket_logging_enabled  = true
  target_bucket           = "bucket-logs12"
  target_prefix           = "logs"
}
```
### Website Host Bucket
```hcl
module "s3_bucket" {
  source                              = "clouddrove/s3/aws"
  version                             = "0.15.0"
  name                                = "clouddrove-website-bucket"
  environment                         = "test"
  label_order                         = ["name", "environment"]
  versioning                          = true
  acl                                 = "private"
  website_hosting_bucket              = true
  website_index                       = "index.html"
  website_error                       = "error.html"
  bucket_policy                       = true
  lifecycle_expiration_enabled        = true
  lifecycle_expiration_object_prefix  = "test"
  lifecycle_days_to_expiration        = 10
  aws_iam_policy_document             = data.aws_iam_policy_document.default.json
}
data "aws_iam_policy_document" "default" {
  version = "2012-10-17"
  statement {
       sid = "Stmt1547315805704"
       effect = "Allow"
       principals {
            type = "AWS"
            identifiers = ["*"]
          }
       actions = ["s3:GetObject"]
       resources = ["arn:aws:s3:::clouddrove-website-bucket-test/*"]
   }
}
```






## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| acceleration\_status | Sets the accelerate configuration of an existing bucket. Can be Enabled or Suspended | `string` | `null` | no |
| acl | Canned ACL to apply to the S3 bucket. | `string` | `null` | no |
| attributes | Additional attributes (e.g. `1`). | `list(any)` | `[]` | no |
| aws\_iam\_policy\_document | Specifies the number of days after object creation when the object expires. | `string` | `""` | no |
| bucket\_policy | Conditionally create S3 bucket policy. | `bool` | `false` | no |
| bucket\_prefix | (Optional, Forces new resource) Creates a unique bucket name beginning with the specified prefix. | `string` | `null` | no |
| cors\_rule | CORS Configuration specification for this bucket | <pre>list(object({<br>    allowed_headers = list(string)<br>    allowed_methods = list(string)<br>    allowed_origins = list(string)<br>    expose_headers  = list(string)<br>    max_age_seconds = number<br>  }))</pre> | `null` | no |
| create\_bucket | Conditionally create S3 bucket. | `bool` | `true` | no |
| delimiter | Delimiter to be used between `organization`, `environment`, `name` and `attributes`. | `string` | `"-"` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| force\_destroy | A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. | `bool` | `false` | no |
| grants | ACL Policy grant.conflict with acl.set acl null to use this | <pre>list(object({<br>    id          = string<br>    type        = string<br>    permissions = list(string)<br>    uri         = string<br>  }))</pre> | `null` | no |
| kms\_master\_key\_id | The AWS KMS master key ID used for the SSE-KMS encryption. This can only be used when you set the value of sse\_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse\_algorithm is aws:kms. | `string` | `""` | no |
| label\_order | Label order, e.g. `name`,`application`. | `list(any)` | `[]` | no |
| lifecycle\_days\_to\_deep\_archive\_transition | Specifies the number of days after object creation when it will be moved to DEEP ARCHIVE . | `number` | `180` | no |
| lifecycle\_days\_to\_expiration | Specifies the number of days after object creation when the object expires. | `number` | `365` | no |
| lifecycle\_days\_to\_glacier\_transition | Specifies the number of days after object creation when it will be moved to Glacier storage. | `number` | `180` | no |
| lifecycle\_days\_to\_infrequent\_storage\_transition | Specifies the number of days after object creation when it will be moved to standard infrequent access storage. | `number` | `60` | no |
| lifecycle\_deep\_archive\_object\_prefix | Object key prefix identifying one or more objects to which the lifecycle rule applies. | `string` | `""` | no |
| lifecycle\_deep\_archive\_transition\_enabled | Specifies DEEP ARCHIVE transition lifecycle rule status. | `bool` | `false` | no |
| lifecycle\_expiration\_enabled | Specifies expiration lifecycle rule status. | `bool` | `false` | no |
| lifecycle\_expiration\_object\_prefix | Object key prefix identifying one or more objects to which the lifecycle rule applies. | `string` | `""` | no |
| lifecycle\_glacier\_object\_prefix | Object key prefix identifying one or more objects to which the lifecycle rule applies. | `string` | `""` | no |
| lifecycle\_glacier\_transition\_enabled | Specifies Glacier transition lifecycle rule status. | `bool` | `false` | no |
| lifecycle\_infrequent\_storage\_object\_prefix | Object key prefix identifying one or more objects to which the lifecycle rule applies. | `string` | `""` | no |
| lifecycle\_infrequent\_storage\_transition\_enabled | Specifies infrequent storage transition lifecycle rule status. | `bool` | `false` | no |
| logging | Logging Object Configuration details | `map(string)` | `{}` | no |
| managedby | ManagedBy, eg 'CloudDrove'. | `string` | `"hello@clouddrove.com"` | no |
| mfa\_delete | Enable MFA delete for either Change the versioning state of your bucket or Permanently delete an object version. | `bool` | `false` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| object\_lock\_configuration | With S3 Object Lock, you can store objects using a write-once-read-many (WORM) model. Object Lock can help prevent objects from being deleted or overwritten for a fixed amount of time or indefinitely. | <pre>object({<br>    mode  = string<br>    days  = number<br>    years = number<br>  })</pre> | `null` | no |
| repository | Terraform current module repo | `string` | `"https://github.com/clouddrove/terraform-aws-s3"` | no |
| request\_payer | Specifies who should bear the cost of Amazon S3 data transfer. Can be either BucketOwner or Requester. By default, the owner of the S3 bucket would incur the costs of any data transfer | `string` | `null` | no |
| sse\_algorithm | The server-side encryption algorithm to use. Valid values are AES256 and aws:kms. | `string` | `"AES256"` | no |
| tags | Additional tags (e.g. map(`BusinessUnit`,`XYZ`). | `map(any)` | `{}` | no |
| versioning | Enable Versioning of S3. | `bool` | `true` | no |
| website | Static website configuration | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN of the s3 bucket. |
| bucket\_domain\_name | The Domain of the s3 bucket. |
| id | The ID of the s3 bucket. |
| tags | A mapping of tags to assign to the resource. |




## Testing
In this module testing is performed with [terratest](https://github.com/gruntwork-io/terratest) and it creates a small piece of infrastructure, matches the output like ARN, ID and Tags name etc and destroy infrastructure in your AWS account. This testing is written in GO, so you need a [GO environment](https://golang.org/doc/install) in your system. 

You need to run the following command in the testing folder:
```hcl
  go test -run Test
```



## Feedback 
If you come accross a bug or have any feedback, please log it in our [issue tracker](https://github.com/clouddrove/terraform-aws-s3/issues), or feel free to drop us an email at [hello@clouddrove.com](mailto:hello@clouddrove.com).

If you have found it worth your time, go ahead and give us a ★ on [our GitHub](https://github.com/clouddrove/terraform-aws-s3)!

## About us

At [CloudDrove][website], we offer expert guidance, implementation support and services to help organisations accelerate their journey to the cloud. Our services include docker and container orchestration, cloud migration and adoption, infrastructure automation, application modernisation and remediation, and performance engineering.

<p align="center">We are <b> The Cloud Experts!</b></p>
<hr />
<p align="center">We ❤️  <a href="https://github.com/clouddrove">Open Source</a> and you can check out <a href="https://github.com/clouddrove">our other modules</a> to get help with your new Cloud ideas.</p>

  [website]: https://clouddrove.com
  [github]: https://github.com/clouddrove
  [linkedin]: https://cpco.io/linkedin
  [twitter]: https://twitter.com/clouddrove/
  [email]: https://clouddrove.com/contact-us.html
  [terraform_modules]: https://github.com/clouddrove?utf8=%E2%9C%93&q=terraform-&type=&language=
