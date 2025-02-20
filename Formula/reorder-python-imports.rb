class ReorderPythonImports < Formula
  include Language::Python::Virtualenv

  desc "Rewrites source to reorder python imports"
  homepage "https://github.com/asottile/reorder_python_imports"
  url "https://files.pythonhosted.org/packages/08/ad/98b68a155caf91ef304613fc7b5784b8963a7625a4e23231d6cf5b0d1aa6/reorder_python_imports-3.2.1.tar.gz"
  sha256 "a4988cc3de791134d8dd1e593245305219b5ab48b9e65f26a5c474320fdef4a9"
  license "MIT"
  head "https://github.com/asottile/reorder_python_imports.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1da5d28f208b0bc35b0d4ae7fe24cbd4cb9b2a3217e21c84aecadbcff2553486"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "1da5d28f208b0bc35b0d4ae7fe24cbd4cb9b2a3217e21c84aecadbcff2553486"
    sha256 cellar: :any_skip_relocation, monterey:       "6d0279e78f05a73ed9d123cb6c8e5afef158bdd89aca0fcce09db1420d7c34ca"
    sha256 cellar: :any_skip_relocation, big_sur:        "6d0279e78f05a73ed9d123cb6c8e5afef158bdd89aca0fcce09db1420d7c34ca"
    sha256 cellar: :any_skip_relocation, catalina:       "6d0279e78f05a73ed9d123cb6c8e5afef158bdd89aca0fcce09db1420d7c34ca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1a7ff2e5ea4c1f88ae0bfbb62374a119c7b534ff186db28fe6ee1a1bfee78146"
  end

  depends_on "python@3.10"

  resource "classify-imports" do
    url "https://files.pythonhosted.org/packages/b5/98/9541d3f96f8754ee3f2ecf09f0689fd5d0bb097e769a0b34585425e2d316/classify_imports-4.0.2.tar.gz"
    sha256 "a1880ba36cca1a3e6efc338698685c3c93019c92ecb7cc246636abb42c621e7f"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    (testpath/"test.py").write <<~EOS
      from os import path
      import sys
    EOS
    system "#{bin}/reorder-python-imports", "--exit-zero-even-if-changed", "#{testpath}/test.py"
    assert_equal("import sys\nfrom os import path\n", File.read(testpath/"test.py"))
  end
end
