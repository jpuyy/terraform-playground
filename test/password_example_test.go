package test

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestPasswordExample(t *testing.T) {
	opts := &terraform.Options{
		TerraformDir: "../password",
	}

	defer terraform.Destroy(t, opts)

	terraform.Init(t, opts)
	terraform.Apply(t, opts)

	password_output := terraform.OutputRequired(t, opts, "random_password")
	fmt.Println(password_output)
}
