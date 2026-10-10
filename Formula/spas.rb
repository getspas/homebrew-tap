class Spas < Formula
  desc "Manage private assets in Git workspaces"
  homepage "https://github.com/getspas/spas"
  url "https://github.com/getspas/spas/releases/download/v0.1.5/spas_0.1.5_source.tar.gz"
  sha256 "31f10bba8918cd49f46d6c7a6b0d3ae9a19eb58e96459169597ed6f8cb2ff491"
  license "AGPL-3.0-only"

  depends_on "go" => :build
  depends_on "git"

  def install
    ENV["CGO_ENABLED"] = "0"
    ldflags = %W[
      -X github.com/getspas/spas/internal/version.Version=#{version}
      -X github.com/getspas/spas/internal/version.Commit=3cf77106decca159b01c940661db6c9e77fa160f
      -X github.com/getspas/spas/internal/version.Date=2026-10-09T16:55:41-05:00
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
    assert_equal "3cf77106decca159b01c940661db6c9e77fa160f", result.fetch("commit")
    assert_match "Usage:", shell_output("#{bin}/spas --help")
  end
end
