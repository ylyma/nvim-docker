return {
  'cbochs/grapple.nvim',
  opts = {
    scope = 'git', -- also try out "git_branch"
  },
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = 'Grapple',
  keys = {
    { '<leader>m', '<cmd>Grapple toggle<cr>', desc = 'Grapple toggle tag' },
    { '<leader>M', '<cmd>Grapple toggle_tags<cr>', desc = 'Grapple open tags window' },
    { '<leader>n', '<cmd>Grapple cycle_tags next<cr>', desc = 'Grapple cycle next tag' },
    { '<leader>N', '<cmd>Grapple cycle_tags prev<cr>', desc = 'Grapple cycle previous tag' },
  },
}
