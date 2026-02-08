-- User accounts with empty passwords, allowing anyone to log in.
--
-- platform: linux
-- tags: persistent state
SELECT
  *
FROM
  users
  JOIN shadow USING (uid)
WHERE
  shadow.password = '';
