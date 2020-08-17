
resource "google_storage_bucket_iam_policy" "testing" {
  bucket = "b/testing"

  policy_data = <<POLICY
{
  "bindings": [
    {
      "members": [
        "user:chechia.chang@chechia.net"
      ],
      "role": "roles/storage.admin"
    },
    {
      "members": [
        "projectEditor:myproject",
        "projectOwner:myproject"
      ],
      "role": "roles/storage.legacyBucketOwner"
    },
    {
      "members": [
        "projectViewer:myproject"
      ],
      "role": "roles/storage.legacyBucketReader"
    },
    {
      "members": [
        "user:david.chang@chechia.net"
      ],
      "role": "roles/storage.objectAdmin"
    },
    {
      "members": [
        "allUsers"
      ],
      "role": "roles/storage.objectViewer"
    }
  ]
}
POLICY
}
