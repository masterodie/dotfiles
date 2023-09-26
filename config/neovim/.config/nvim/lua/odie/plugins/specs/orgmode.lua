local M = {
  "nvim-orgmode/orgmode",
}

M.lazy = false

M.opts = {
  org_agenda_files = { "~/Sync/org/**/*" },
  org_default_notes_file = "~/Sync/org/notes.org",
  org_indent_mode = "noindent",
}

return M
