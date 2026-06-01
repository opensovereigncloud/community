# ironcore-dev Community

This repository contains the governance documentation and automation
for the [ironcore-dev](https://github.com/ironcore-dev) GitHub
organization. It defines how community members participate, how roles
are assigned, and how organizational permissions are enforced.

Community members and repositories are maintained in the `teams.yaml` and
`repositories.yaml` files. See [Automation](#automation) for how the contents of
those files are enforced.

## Areas

Repositories are organized into three areas, each with dedicated maintainer and
contributor teams. In addition, repositories for org governance, tooling, etc.
which do not belong to any of the three areas are maintained by the Technical
Steering Committee (TSC).

- **IaaS** — Compute, storage, and virtualization
  (e.g., ironcore, ceph-provider, libvirt-provider)
- **Metal** — Bare-metal provisioning
  (e.g., metal-operator, boot-operator, ipam)
- **Network** — Dataplane and routing
  (e.g., dpservice, ironcore-net, metalbond)
- **TSC** — Governance and shared tooling
  (e.g., community, enhancements, steering)

## Roles

The community defines three roles with increasing levels of responsibility:

| Role             | Summary                                |
|------------------|----------------------------------------|
| **Contributor**  | Active member with merged contributions|
| **Maintainer**   | Trusted contributor; merges and triage |
| **TSC Member**   | Technical Steering Committee           |

See [Roles & Membership](docs/roles-and-membership.md) for more details and how
to become a community member.

## Governance

Changes to community governance (this repository) require approval
from 4 TSC members. Changes like role nominations and revocations follow the
process defined in [Roles & Membership](docs/roles-and-membership.md).

## Automation

Team memberships and repository permissions are enforced
declaratively using OpenTofu via GitHub Actions. Configuration is
defined in `teams.yaml` and `repositories.yaml`, and changes require
TSC approval before being applied.
