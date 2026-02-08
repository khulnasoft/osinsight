-- System Integrity Protection (SIP) is disabled
--
-- platform: darwin
-- tags: persistent state
SELECT
  *
FROM
  sip_config
WHERE
  config_flag = 'sip'
  AND enabled = 0;
