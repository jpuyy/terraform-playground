package test

import (
	"fmt"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"testing"
)

func TestPasswordExample(t *testing.T) {
	opts := &terraform.Options{
		TerraformDir: "../password",
	}

	terraform.Init(t, opts)
	terraform.Apply(t, opts)

	password_output := terraform.OutputRequired(t, opts, "random_password")
	fmt.Println(password_output)
}
