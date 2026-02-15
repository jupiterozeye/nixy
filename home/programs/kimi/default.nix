{
  lib,
  python3,
  fetchFromGitHub,
}:

python3.pkgs.buildPythonApplication rec {
  pname = "kimi-cli";
  version = "1.8.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "MoonshotAI";
    repo = "kimi-cli";
    rev = version;
    hash = "sha256-QTvLMHnqhyNxsHgY5riBTUKuhdaH7jbdIZ2sjQOF1rs=";
  };

  build-system = [
    python3.pkgs.uv-build
  ];

  dependencies = with python3.pkgs; [
    agent-client-protocol
    aiofiles
    aiohttp
    batrachian-toad
    fastapi
    fastmcp
    httpx
    jinja2
    keyring
    kosong
    loguru
    lxml
    pillow
    prompt-toolkit
    pydantic
    pykaos
    pyobjc-framework-cocoa
    pyyaml
    rich
    ripgrepy
    scalar-fastapi
    streamingjson
    tenacity
    tomlkit
    trafilatura
    typer
    uvicorn
    websockets
  ];

  pythonImportsCheck = [
    "kimi_cli"
  ];

  meta = {
    description = "Kimi Code CLI is your next CLI agent";
    homepage = "https://github.com/MoonshotAI/kimi-cli";
    changelog = "https://github.com/MoonshotAI/kimi-cli/blob/${src.rev}/CHANGELOG.md";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "kimi-cli";
  };
}
