-- Detects processes that are executing from an anonymous in-memory file descriptor (memfd).
--
-- This is a common technique used by fileless malware on Linux to execute code
-- without leaving a trace on the physical disk.
--
-- references:
--   * https://attack.mitre.org/techniques/T1027/004/ (Obfuscated Files or Information: Compile After Delivery)
--   * https://0x00sec.org/t/super-stealthy-droppers/3715
--
-- tags: persistent process isolation
-- platform: linux
SELECT
  p.pid,
  p.name,
  p.path,
  p.cmdline,
  p.cwd,
  p.euid,
  p.parent,
  pp.name AS parent_name,
  pp.path AS parent_path
FROM
  processes p
  LEFT JOIN processes pp ON p.parent = pp.pid
WHERE
  p.path LIKE 'memfd:%'
  OR p.path LIKE '/memfd:%'
  OR p.path LIKE 'anon_inode:memfd%'
  OR p.path LIKE '/anon_inode:memfd%';
