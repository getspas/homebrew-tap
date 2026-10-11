class Spas < Formula
  desc "Manage private assets in Git workspaces"
  homepage "https://github.com/getspas/spas"
  url "https://github.com/getspas/spas/archive/refs/tags/v0.1.6.tar.gz"
  sha256 "5e1617af957e43d763421e4a775aba4beb80a639b0cd75994e5dca8a7195ee25"
  license "AGPL-3.0-only"

  depends_on "go" => :build
  depends_on "git"

  def install
    ENV["CGO_ENABLED"] = "0"
    ldflags = %W[
      -X github.com/getspas/spas/internal/version.Version=#{version}
      -X github.com/getspas/spas/internal/version.Commit=7e03c316b5f566828e206f6684d7be6739c571a9
      -X github.com/getspas/spas/internal/version.Date=2026-10-10T04:12:43-05:00
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
    assert_equal "7e03c316b5f566828e206f6684d7be6739c571a9", result.fetch("commit")
    assert_match "Usage:", shell_output("#{bin}/spas --help")
  end
end
