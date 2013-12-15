module Rye::Box::Cmd
  def git(*args); run_command("/usr/bin/git", args); end
  def git_fetch(*args); run_command("/usr/bin/git fetch --all ", args); end
  def git_reset(*args); run_command("/usr/bin/git reset --hard origin/master ", args); end
end