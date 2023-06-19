require("plugins")

vim.api.nvim_command('colorscheme darcula')

vim.o.number=true           -- show line numbers
vim.o.mouse="a"             -- enable mouse support
vim.o.shiftwidth=4          -- size of an indent
vim.o.softtabstop=4         -- number of spaces in tab when editing
vim.o.termguicolors=true    -- enable 24-bit RGB colors
vim.o.showmode=false        -- we don't need to see things like -- INSERT -- anymore
vim.o.smartcase=true        -- smart case

vim.g.loaded_netrw = 1          -- required by nvim-tree
vim.g.loaded_netrwPlugin = 1    -- required by nvim-tree

require("nvim-tree").setup({
    view = {
        width = 40              -- width of the slide bar
    }
})

-- 当打开nvim-tree的侧边栏时，使文件顶部的文件标签自动偏移view的宽度
vim.api.nvim_create_autocmd('FileType', {
    callback = function(tbl)
      local set_offset = require('bufferline.api').set_offset
  
      local bufwinid
      local last_width
      local autocmd = vim.api.nvim_create_autocmd('WinScrolled', {
        callback = function()
          bufwinid = bufwinid or vim.fn.bufwinid(tbl.buf)
  
          local width = vim.api.nvim_win_get_width(bufwinid)
          if width ~= last_width then
            set_offset(width, 'FileTree')
            last_width = width
          end
        end,
      })
  
      vim.api.nvim_create_autocmd('BufWipeout', {
        buffer = tbl.buf,
        callback = function()
          vim.api.nvim_del_autocmd(autocmd)
          set_offset(0)
        end,
        once = true,
      })
    end,
    pattern = 'NvimTree', -- or any other filetree's `ft`
  })


local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
-- Close buffer
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)

vim.api.nvim_set_keymap('', ' ', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
-- Space+j
vim.api.nvim_set_keymap('n', '<leader>j', ':NvimTreeToggle<CR>', { noremap = true })  -- 打开/关闭文件树

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)   -- 打开错误提示
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)           -- 跳转到上一个错误
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)           -- 跳转到下一个错误
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)   -- 打开错误列表


require'lspconfig'.pyright.setup{}    -- python
require'lspconfig'.tsserver.setup{}   -- typescript


-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
