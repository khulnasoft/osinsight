-- Gatekeeper assessments are disabled
--
-- platform: darwin
-- tags: persistent state
SELECT
  *
FROM
  gatekeeper
WHERE
  assessments_enabled = 0;
