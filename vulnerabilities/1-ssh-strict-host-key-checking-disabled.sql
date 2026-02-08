-- SSH client configuration has StrictHostKeyChecking disabled, making it vulnerable to man-in-the-middle attacks.
--
-- platform: posix
-- tags: persistent state
SELECT
  u.username,
  s.block,
  s.key,
  s.value
FROM
  users u
  JOIN ssh_configs s USING (uid)
WHERE
  s.key = 'StrictHostKeyChecking'
  AND s.value = 'no';
