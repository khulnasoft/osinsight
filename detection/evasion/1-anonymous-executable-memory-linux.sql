-- Processes with executable memory regions that are not backed by a file.
--
-- This is a strong indicator of shellcode injection or fileless malware.
--
-- references:
--   * https://attack.mitre.org/techniques/T1055/ (Process Injection)
--
-- tags: persistent process isolation
-- platform: linux
SELECT
  p.name,
  p.path,
  p.cmdline,
  pmm.path AS mapping_path,
  pmm.permissions,
  pmm.start AS mapping_start,
  pmm.end AS mapping_end,
  (pmm.end - pmm.start) AS size
FROM
  processes p
  JOIN process_memory_map pmm ON p.pid = pmm.pid
WHERE
  pmm.permissions LIKE '%x'
  AND pmm.path = ''
  AND pmm.device = '00:00'
  AND pmm.pseudo = 0
  -- Common JIT engines often use anonymous executable memory
  AND p.name NOT IN (
    'chrome',
    'chromium',
    'electron',
    'firefox',
    'go',
    'java',
    'node',
    'python',
    'python3',
    'v8',
    'code'
  )
  AND p.path NOT LIKE '/usr/bin/qemu-%'
  AND p.path NOT LIKE '/usr/lib/jvm/%'
  AND p.path NOT LIKE '/opt/google/chrome/%'
  AND p.path NOT LIKE '/usr/lib/electron/%';
