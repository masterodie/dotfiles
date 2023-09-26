local M = {
    "weilbith/nvim-code-action-menu",
}

M.event = { "BufReadPre", "BufNewFile" }

M.cmd = "CodeActionMenu"

return M
