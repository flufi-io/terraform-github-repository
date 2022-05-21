package test

import (
	"github.com/gruntwork-io/terratest/modules/random"
	"log"
	"os"
	"strconv"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestCompleteExample(t *testing.T) {

	templateFiles := []string{
		"../../.config/.terraform-docs.yml",

		"../../.github/workflows/terraform-docs.yml",
		"../../.github/workflows/terratest.yml",
		"../../.github/workflows/tfsec.yml",

		"../../.gitignore",
		"../../main.tf",
		"../../variables.tf",
		"../../versions.tf",
		"../../outputs.tf",
		"../../README.md",

		"../../examples/complete/main.tf",
		"../../examples/complete/variables.tf",
		"../../examples/complete/versions.tf",
		"../../examples/complete/outputs.tf",
		"../../examples/complete/terraform.tfvars",
		"../../examples/complete/providers.tf",

		"../../tests/complete/complete_test.go",
	}
	// DELAY is the time in seconds to run terraform destroy after terraform apply
	DELAY, _ := strconv.Atoi(os.Getenv("DELAY"))
	uniqueID := random.UniqueId()
	repoName := "template-repository-" + uniqueID
	varFiles := []string{"../../examples/complete/terraform.tfvars"}
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../examples/complete",
		Vars: map[string]interface{}{
			"name":                  repoName,
			"description":           "testing template repository",
			"visibility":            "public",
			"template_files":        templateFiles,
			"template_files_prefix": "../../",
		},
		VarFiles:    varFiles,
		Upgrade:     true,
		Reconfigure: true,
	})

	defer terraform.Destroy(t, terraformOptions)
	// Delay the execution of the terraform destroy
	defer func() {
		delay(DELAY)
	}()

	terraform.InitAndApply(t, terraformOptions)

	output := terraform.Output(t, terraformOptions, "repository_name")
	assert.Equal(t, repoName, output)
}

func delay(seconds int) {
	for {
		if seconds <= 0 {
			break
		} else {
			log.Println(seconds)
			time.Sleep(1 * time.Second)
			seconds--
		}
	}
}
