require 'test_helper'

class OnlineFetchTest < Rugged::TestCase
  def test_fetch_over_git
    Dir.mktmpdir do |dir|
      repo = Rugged::Repository.init_at(dir)

      remote = Rugged::Remote.add(repo, "origin", "https://github.com/libgit2/TestGitRepository.git")
      remote.fetch

      assert_equal 5, repo.refs.count
      assert_equal [
        "refs/remotes/origin/first-merge",
        "refs/remotes/origin/master",
        "refs/remotes/origin/no-parent",
        "refs/tags/blob",
        "refs/tags/commit_tree"
      ], repo.refs.map(&:name).sort
    end
  end
end