{ lib
, aiohttp
, aresponses
, buildPythonPackage
, certifi
, fetchFromGitHub
, poetry-core
, pytest-aiohttp
, pytest-asyncio
, pytestCheckHook
, pythonOlder
, yarl
}:

buildPythonPackage rec {
  pname = "aiowatttime";
  version = "2023.10.0";
  format = "pyproject";

  disabled = pythonOlder "3.10";

  src = fetchFromGitHub {
    owner = "bachya";
    repo = pname;
    rev = "refs/tags/${version}";
    hash = "sha256-3cVs/mIMkHx5jyfICL+I9pOr0uCV2uzasrEcAN4UFGg=";
  };

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    aiohttp
    certifi
    yarl
  ];

  __darwinAllowLocalNetworking = true;

  nativeCheckInputs = [
    aresponses
    pytest-aiohttp
    pytest-asyncio
    pytestCheckHook
  ];

  # Ignore the examples directory as the files are prefixed with test_
  disabledTestPaths = [ "examples/" ];

  pythonImportsCheck = [ "aiowatttime" ];

  meta = with lib; {
    description = "Python library for interacting with WattTime";
    homepage = "https://github.com/bachya/aiowatttime";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
  };
}
