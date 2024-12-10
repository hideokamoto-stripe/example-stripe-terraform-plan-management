# [Example] Price and entitlement management with Terraform

Simple demo and example of how to manage and deploy pricing / entitlement as code with Terraform.

The demo uses the [Stripe Provider](https://registry.terraform.io/providers/lukasaron/stripe/latest/docs) owned by [@lukasaron](https://github.com/lukasaron).

## Get started

Clone this repository and navigate to the project directory:

```bash
$ git clone git@github.com:hideokamoto-stripe/example-stripe-terraform-plan-management.git
$ cd example-stripe-terraform-plan-management
```

Configure the Stripe API key. This is necessary for Terraform to interact with your Stripe account:

```bash
$ export TF_VAR_stripe_api_key=sk_test_xxx
```


Initialize the Terraform project:

```bash
$ terraform init
```


## Review the change
You can review the changes by the `terraform plan` command below.

```bash
$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # stripe_price.standard_monthly_price will be created
  + resource "stripe_price" "standard_monthly_price" {
      + active              = true
      + billing_scheme      = (known after apply)
      + currency            = "jpy"
      + id                  = (known after apply)
      + product             = (known after apply)
      + tax_behavior        = "unspecified"
      + transfer_lookup_key = false
      + type                = (known after apply)
      + unit_amount         = 9800
      + unit_amount_decimal = (known after apply)

      + recurring {
          + interval       = "month"
          + interval_count = 1
          + usage_type     = "licensed"
        }
    }

  # stripe_product.standard_product will be created
  + resource "stripe_product" "standard_product" {
      + active      = true
      + description = "Awesome SaaS license"
      + id          = (known after apply)
      + name        = "Standard license"
      + product_id  = (known after apply)
      + unit_label  = "seat"
    }

```

## Deploy

Run the `terraform apply` command to deploy the configuration.

```bash
$ terraform apply

stripe_entitlements_feature.feature_dashboard_access: Creating...
stripe_entitlements_feature.feature_rest_api_access: Creating...
stripe_entitlements_feature.feature_dashboard_access: Creation complete after 0s [id=feat_test_61RdNK3uaykEjKMIF41Q9mxJNCzY5NpA]
stripe_entitlements_feature.feature_rest_api_access: Creation complete after 0s [id=feat_test_61RdNK3ElxDCVoZjF41Q9mxJNCzY5TSy]
stripe_product_feature.standard_product_feature_dashboard_access: Creating...
stripe_product_feature.hobby_product_feature_dashboard_access: Creating...
stripe_product_feature.standard_product_feature_rest_api_access: Creating...
stripe_product_feature.standard_product_feature_rest_api_access: Creation complete after 1s [id=prodft_1QTzMiQ9mxJNCzY5WYYoE4OS]
stripe_product_feature.hobby_product_feature_dashboard_access: Creation complete after 1s [id=prodft_1QTzMiQ9mxJNCzY57PhuX12n]
stripe_product_feature.standard_product_feature_dashboard_access: Creation complete after 1s [id=prodft_1QTzMiQ9mxJNCzY5lJovSY2f]

Apply complete! Resources: 5 added, 0 changed, 0 destroyed.
```