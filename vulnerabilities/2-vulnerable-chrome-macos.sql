-- Vulnerable version of Google Chrome is installed (less than 120.0.6099.129)
--
-- References:
--   * https://chromereleases.googleblog.com/2023/12/stable-channel-update-for-desktop_20.html (CVE-2023-7024)
--
-- tags: persistent state filesystem
-- platform: darwin
SELECT
  name,
  path,
  bundle_short_version,
  TRIM(REGEX_MATCH (bundle_short_version, "^(\d+)\.", 1)) AS major,
  TRIM(REGEX_MATCH (bundle_short_version, "\.(\d+)$", 1)) AS patch
FROM
  apps
WHERE
  name = 'Google Chrome'
  AND (
    CAST(major AS integer) < 120
    OR (
      major = '120'
      AND CAST(patch AS integer) < 129
    )
  );
