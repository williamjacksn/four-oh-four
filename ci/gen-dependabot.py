import json
import pathlib


def update(ecosystem: str) -> dict:
    return {
        "package-ecosystem": ecosystem,
        "allow": [{"dependency-type": "all"}],
        "directory": "/",
        "schedule": {"interval": "daily"},
    }


content = {
    "version": 2,
    "updates": [update(e) for e in ["docker", "github-actions", "uv"]],
}

target = pathlib.Path(".github/dependabot.yaml")
target.write_text(json.dumps(content, indent=2, sort_keys=True))
