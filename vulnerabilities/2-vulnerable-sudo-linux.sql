-- Legacy version of sudo is installed, potentially vulnerable to major CVEs (like Baron Samedit CVE-2021-3156)
--
-- References:
--   * https://blog.qualys.com/vulnerabilities-threat-research/2021/01/26/vulnerability-2021-3156-sudo-baron-samedit-heap-based-buffer-overflow
--
-- tags: persistent state
-- platform: linux
SELECT
  name,
  version,
  TRIM(REGEX_MATCH (version, "^(\d+)\.", 1)) AS major,
  TRIM(REGEX_MATCH (version, "\.(\d+)\.", 1)) AS minor,
  TRIM(REGEX_MATCH (version, "\.(\d+)p", 1)) AS patch
FROM
  package_cache
WHERE
  name = 'sudo'
  AND (
    CAST(major AS integer) < 1
    OR (
      major = '1'
      AND (
        CAST(minor AS integer) < 9
        OR (
          minor = '9'
          AND CAST(patch AS integer) < 5
        )
      )
    )
  );
