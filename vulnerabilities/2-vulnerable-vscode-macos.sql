-- Vulnerable version of Visual Studio Code is installed (less than 1.82)
--
-- References:
--   * https://msrc.microsoft.com/update-guide/vulnerability/CVE-2023-36742
--
-- tags: persistent state filesystem
-- platform: darwin
SELECT
  name,
  path,
  bundle_short_version,
  TRIM(REGEX_MATCH (bundle_short_version, "^(\d+)\.", 1)) AS major,
  TRIM(REGEX_MATCH (bundle_short_version, "\.(\d+)\.", 1)) AS minor
FROM
  apps
WHERE
  name = 'Visual Studio Code'
  AND (
    CAST(major AS integer) < 1
    OR (
      major = '1'
      AND CAST(minor AS integer) < 82
    )
  );
