### workspace help
`terraform workspace`
  new, list, show, select and delete Terraform workspaces.

Subcommands:

    `delete`    Delete a workspace

    `list`      List Workspaces

    `new`       Create a new workspace

    `select`    Select a workspace

    `show`      Show the name of the current workspace

### workspace create
`terraform workspace new <env-name>`

`terraform workspace new dev`

`terraform workspace new qa`

`terraform workspace new prod`

### switch envs
`terraform workspace select dev`

### list envs
`terraform workspace list`

### list delete
`terraform workspace delete <env-name>`



