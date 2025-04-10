terraform {
  required_providers {
    ibm = {
      source  = "ibm-cloud/ibm"
      version = ">= 1.77.0"
      configuration_aliases = [ ibm, ibm.ibm_cr, ibm.ibm_log ]
    }
  }
} 