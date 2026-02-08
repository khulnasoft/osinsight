-- macOS Application Layer Firewall (ALF) is disabled
--
-- platform: darwin
-- tags: persistent state
SELECT
  *
FROM
  alf
WHERE
  global_state = 0;
