-- Vulnerable version of Zoom is installed (less than 5.16.5)
--
-- References:
--   * https://explore.zoom.us/en/trust/security/security-bulletin/ (ZSB-23056)
--
-- tags: persistent state filesystem
-- platform: darwin
SELECT
  name,
  path,
  bundle_short_version,
  TRIM(REGEX_MATCH (bundle_short_version, "^(\d+)\.", 1)) AS major,
  TRIM(REGEX_MATCH (bundle_short_version, "\.(\d+)\.", 1)) AS minor,
  TRIM(REGEX_MATCH (bundle_short_version, "\.(\d+)$", 1)) AS patch
FROM
  apps
WHERE
  name = 'zoom.us'
  AND (
    CAST(major AS integer) < 5
    OR (
      major = '5'
      AND (
        CAST(minor AS integer) < 16
        OR (
          minor = '16'
          AND CAST(patch AS integer) < 5
        )
      )
    )
  );
