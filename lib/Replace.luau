_G.modular = _G.modular or {}

return _G.modular[script] or (require)((script :: any).Main)
