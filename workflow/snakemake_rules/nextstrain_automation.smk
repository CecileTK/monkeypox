"""
This part of the workflow handles the bells and whistles for automated
Nextstrain builds. Designed to be used internally by the Nextstrain team.

This part of the workflow continues after the main workflow, so the first
rule `deploy` expects input files from `rules.all.input`. It purposely uses the
build name from the config instead of the wildcards so that the rules can be
used as target rules without explicitly defining the output files.

Requires `build_dir` to be defined upstream.
"""
BUILD_NAME= config["build_name"]
DEPLOY_URL = config["deploy_url"]
SLACK_TS_FILE = build_dir + f"/{BUILD_NAME}/slack_thread_ts.txt"

rule deploy:
    input: *rules.all.input
    output:
        touch(build_dir + f"/{BUILD_NAME}/deploy.done")
    params:
        deploy_url = DEPLOY_URL
    shell:
        """
        nextstrain remote upload {params.deploy_url} {input}
        """

onstart:
    # Saves onstart Slack message thread timestamp to file SLACK_TS_FILE
    shell(f"./bin/notify-on-start {config.get('build_name', 'unknown')} {SLACK_TS_FILE}")
