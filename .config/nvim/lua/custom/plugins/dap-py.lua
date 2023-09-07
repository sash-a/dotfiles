-- python's debugger: make sure there's a virtual env with debugpy at ~/.virtualenvs/debugpy/bin/python
-- cd .virtualenvs
-- python -m venv debugpy
-- debugpy/bin/python -m pip install debugpy
return {
  'mfussenegger/nvim-dap-python',
  require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
}
