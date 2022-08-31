# Terraform Beginners Track - Terraform and AWS

## Prerequisites

- Hashicorp Terraform installed.

<p><a href="https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform%2Faws-get-started&amp;wvideo=r3yytnk1pr"><img src="../images/terraform-installation-logo.png?image_play_button_size=2x&amp;image_crop_resized=960x540&amp;image_play_button=1&amp;image_play_button_color=1563ffe0" width="500" height="500" style="width: 520px; height: 320px;"></a></p><p><a href="https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform%2Faws-get-started&amp;wvideo=r3yytnk1pr">Install Terraform | Terraform - HashiCorp Learn</a></p>

- Recommended Code Editors:
  - [Visual Studio Code](https://code.visualstudio.com/download)
  - [Atom](https://atom.io/ )

- AWS Requirements
  - AWS Subscription

    <a href="https://www.loom.com/share/d7079148d10343da92b8398b077b4b5a" target="_blank">

![My image](../images/AWS-Account.png)

</a>

  - Create AWS Access Key and Access Secret credentials

    <a href="https://www.youtube.com/watch?v=vucdm8BWFu0" target="_blank">

![My image](../images/AWS-Credentials.png)

</a>

>> Note: In Permissions make sure you choose "Administrator Access" permissions when creating your user.

# Setup AWS Credentials

## Using environment variables

### macOS Users

```sh
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
export AWS_DEFAULT_REGION=""
```

### Windows Powershell Users

```pwsh
$env:AWS_ACCESS_KEY_ID="AKIAS6MYGOLHBGP3BXX2"
$env:AWS_SECRET_ACCESS_KEY="VVdmLrO0HVwFlj8uxA1234532242r"
$env:AWS_DEFAULT_REGION="us-east-1"
```

## AWS AMI Images Per Region

### Choose the AMI ID According to your region

1. AMS - North Virginia - us-east-1

```sh
ami-052efd3df9dad4825 - t2.micro
ami-070650c005cce4203 - c6g.medium
```

2. EMEA - Frankfurt - eu-central-1

```sh
ami-065deacbcaac64cf2 - t2.micro
ami-07f16fb14274bfc76 - c6g.medium
```

3. APJ - Singapore - ap-southeast-1

```sh
ami-02ee763250491e04a - t2.micro
ami-06ecd61e4bded3bfe - c6g.medium
```
