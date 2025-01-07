return {
  'andrewferrier/debugprint.nvim',
  event = { 'VeryLazy' },
  dependencies = {
    'echasnovski/mini.nvim', -- Needed to enable :ToggleCommentDebugPrints for NeoVim <= 0.9
  },
  -- Remove the following line to use development versions,
  -- not just the formal releases
  version = '*',
}
