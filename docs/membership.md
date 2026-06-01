# Community Membership

The IronCore community recognizes and celebrates regular contributors by inviting
them into formal membership roles. If you contribute to repositories in the
[ironcore-dev](https://github.com/ironcore-dev) GitHub organization, there's a
place for you here.

There are three roles for community members:

- [Contributors](#contributor)
- [Maintainers](#maintainer)
- [TSC Members](#tsc-member)

All community members are grouped in [teams](#team-structure) based on their
role and the area that they are active in.

## Team Structure

Each area of the ironcore-dev organization has two teams:

| Area    | Maintainers Team     | Contributors Team     |
|---------|----------------------|-----------------------|
| IaaS    | `iaas-maintainers`   | `iaas-contributors`   |
| Metal   | `metal-maintainers`  | `metal-contributors`  |
| Network | `network-maintainers`| `network-contributors`|
| TSC     | `tsc`                | -                     |

The TSC operates as a single maintainer team for their repos.

## Contributor

A Contributor is a community member who has demonstrated sustained engagement
with a specific area.

Contributors engage with the community through issues, PRs, and regular attendance
at community meetings. They move the project forward by participating in
discussions, implementing accepted feature requests and fixing bugs.

### Responsibilities

- Participate in issue discussions
- Review PRs
- Implement accepted issues

### How to become a Contributor

Once you've met the requirements below, open a PR to the
[community](https://github.com/ironcore-dev/community) repository adding yourself
to a contributors team in the `teams.yaml` file. A maintainer will review and
approve it there.

#### Requirements

- Minimum **5 interactions** in the target area
  (issues, discussions, pull requests, or reviews)
- At least **1 merged pull request**
- Approval from an active **maintainer** of the target area

## Maintainer

A Maintainer is a trusted contributor responsible for reviewing and merging pull
requests, triaging issues, and guiding contributors in their area. They drive
technical discussions to their conclusion in consensus with other maintainers.

### Responsibilities

- Same responsibilities as contributors
- Approve & merge PRs
- Triage issues

### How to become a Maintainer

Maintainers are nominated by existing maintainers or the TSC. Strong candidates
regularly drive technical discussions to consensus, have a deep understanding of
their area, and have a proven track record of contributions and PR reviews.
Nomination is done through a PR to the `teams.yaml` file.

#### Requirements

- Must already hold the **Contributor** role in the target area
- Approval by **TSC majority vote**

## TSC Member

The Technical Steering Committee (TSC) provides org-wide governance, approves
maintainer nominations, and oversees structural decisions.

### Responsibilities

- Approve or reject maintainer nominations
- Vote on role revocations
- Approve changes to community governance (this repository)
- Oversee repository area assignments

## Revocation

Roles can be revoked from community members under two conditions:

1. **Inactivity** — 6 months without meaningful contribution to the assigned
   area
2. **TSC vote** — Simple majority vote by the TSC

The member is removed from their team and their permissions are updated accordingly.
