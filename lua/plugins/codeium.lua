return {
  'Exafunction/codeium.vim',
  event = 'BufEnter',
  config = function()
    vim.keymap.set('i', '<C-Up>', function() return vim.fn['codeium#CycleCompletions'](1) end,
      { expr = true, silent = true })
    vim.keymap.set('i', '<C-Down>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
      { expr = true, silent = true })
    vim.keymap.set('i', '<C-Right>', function() return vim.fn['codeium#AcceptNextWord']() end,
      { expr = true, silent = true })
    vim.keymap.set('i', '<C-S-Right>', function() return vim.fn['codeium#AcceptNextLine']() end,
      { expr = true, silent = true })
  end,
  
}
