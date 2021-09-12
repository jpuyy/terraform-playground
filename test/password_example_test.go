package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestPasswordExample(t *testing.T) {
	opts := &terraform.Options{
		TerraformDir: "../password",
	}

	terraform.Init(t, opts)
	terraform.Apply(t, opts)
}
