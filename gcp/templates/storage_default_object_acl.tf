
resource "google_storage_default_object_acl" "testing" {
  bucket      = "testing"
  role_entity = ["OWNER:project-editors-307194479120", "OWNER:project-owners-307194479120", "READER:project-viewers-307194479120"]
}
