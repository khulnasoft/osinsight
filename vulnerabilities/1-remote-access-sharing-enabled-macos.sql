-- Remote access sharing features (Screen Sharing, Remote Login, etc) are enabled on macOS
--
-- platform: darwin
-- tags: persistent state
SELECT
  *
FROM
  sharing_preferences
WHERE
  screen_sharing = 1
  OR remote_login = 1
  OR remote_management = 1
  OR remote_apple_events = 1;
