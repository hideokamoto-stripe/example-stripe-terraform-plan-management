terraform {
  required_providers {
    stripe = {
      source = "lukasaron/stripe"
      version = "3.3.0"
    }
  }
}

variable "stripe_api_key" {
  type        = string
}

provider "stripe" {
  api_key = var.stripe_api_key
}

resource "stripe_product" "standard_product" {
  name        = "Standard license"
  unit_label  = "seat"
  description = "Awesome SaaS license"
  active      = true
}

resource "stripe_price" "standard_monthly_price" {
    product     = stripe_product.standard_product.id
    currency    = "jpy"
    unit_amount = 9800
    recurring {
        interval      = "month"
        interval_count = 1
    }
}


resource "stripe_product" "hobby_product" {
  name        = "Hobby"
  unit_label  = "seat"
  description = "Hobby and personal usage plan"
  active      = true
}

resource "stripe_price" "hobby_price" {
    product     = stripe_product.hobby_product.id
    currency    = "jpy"
    unit_amount_decimal = 980
    recurring {
        interval      = "month"
        interval_count = 1
    }
}



resource "stripe_entitlements_feature" "feature_dashboard_access" {
    name       = "Dashboard Access"
    lookup_key = "dashboard_access"
}

resource "stripe_entitlements_feature" "feature_rest_api_access" {
    name       = "REST API Access"
    lookup_key = "rest_api_access"
}

resource "stripe_product_feature" "standard_product_feature_rest_api_access" {
    entitlements_feature = stripe_entitlements_feature.feature_rest_api_access.id
    product              = stripe_product.standard_product.id
}
resource "stripe_product_feature" "hobby_product_feature_dashboard_access" {
    entitlements_feature = stripe_entitlements_feature.feature_dashboard_access.id
    product              = stripe_product.hobby_product.id
}
resource "stripe_product_feature" "standard_product_feature_dashboard_access" {
    entitlements_feature = stripe_entitlements_feature.feature_dashboard_access.id
    product              = stripe_product.standard_product.id
}


