resource "github_team" "team" {
  name                 = var.name
  description          = var.description
  privacy              = var.privacy
  notification_setting = var.notification_setting
}

resource "github_team_members" "members" {
  team_id  = github_team.team.id

 dynamic "members" {
    for_each = { for member in var.members : member.username => member.role }
    content {
      username = members.key
      role     = members.value
    }
  }
}
