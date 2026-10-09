class Spas < Formula
  desc "Manage private assets in Git workspaces"
  homepage "https://github.com/getspas/spas"
  url "https://github.com/getspas/spas/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "d4caa374bf5570e11495ffd1391feed208a3155fd141fe67f87a5eed084e9781"
  license "AGPL-3.0-only"

  depends_on "go" => :build
  depends_on "git"

  def install
    ENV["CGO_ENABLED"] = "0"
    ldflags = %W[
      -X github.com/getspas/spas/internal/version.Version=#{version}
      -X github.com/getspas/spas/internal/version.Commit=d643395514d4cfe8cfe0c1358e48936265405c99
      -X github.com/getspas/spas/internal/version.Date=2026-09-12T11:33:45Z
    ].join(" ")
    system "go", "build", *std_go_args(ldflags: ldflags), "."
    generate_completions_from_executable(bin/"spas", shell_parameter_format: :cobra)
    doc.install "README.md"
    (pkgshare/"licenses").install "LICENSE"
  end

  def caveats
    "Requires Git 2.43.1 or newer."
  end

  test do
    result = JSON.parse(shell_output("#{bin}/spas version --json"))
    assert_equal version.to_s, result.fetch("version")
    assert_equal "d643395514d4cfe8cfe0c1358e48936265405c99", result.fetch("commit")
    assert_match "Usage:", shell_output("#{bin}/spas --help")
  end
end
