package buildkite

default allow = false

allow {
    input.event.type == "build"
    input.event.state == "scheduled"
    input.pipeline.name == "my-pipeline"
    input.pipeline.default_branch == "main"
}

allow {
    input.event.type == "build"
    input.event.state == "scheduled"
    input.pipeline.name == "my-pipeline"
    input.pipeline.default_branch == "develop"
}

allow {
    input.event.type == "build"
    input.event.state == "scheduled"
    input.pipeline.name == "my-pipeline"
    input.pipeline.branch_configuration == "protected"
    input.pipeline.branches[_] == input.event.branch
}

allow {
    input.event.type == "build"
    input.event.state == "scheduled"
    input.pipeline.name == "my-pipeline"
    input.pipeline.branch_configuration == "open"
}
