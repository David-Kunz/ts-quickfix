local M = {}

local function quickfix(opts)
    local parser = require('nvim-treesitter.parsers').get_parser()
    if not parser then return end
    local lang = parser:lang()
    local query
    if opts.name then
        query = vim.treesitter.get_query(lang, opts.name)
    else
        if opts.query_string then
            local ok, q = pcall(vim.treesitter.parse_query, lang,
                                opts.query_string)
            if not ok then return end
            query = q
        end
    end
    local tree = parser:parse()[1]
    local bufnr = vim.api.nvim_get_current_buf()
    local qf_table = {}
    for _, node in query:iter_captures(tree:root(), 0) do
        local text = vim.treesitter.query.get_node_text(node, 0)
        local start_row, start_col = node:range()
        table.insert(qf_table, {
            bufnr = bufnr,
            lnum = start_row + 1,
            col = start_col + 1,
            text = text
        })
    end
    if not next(qf_table) then return end
    vim.fn.setqflist(qf_table)
    vim.cmd.copen()
end

M.query_name = function(name) quickfix({name = name}) end

M.query = function(query_string) quickfix({query_string = query_string}) end

M.todo = function()
    M.query(
        '((comment) @comment (#match? @comment "[^a-zA-Z0-9](TODO|HACK|WARNING|BUG|FIXME|XXX|REVISIT)"))')
end

return M
