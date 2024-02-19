local M = {}

-- Default configuration
M.config = {
    highlight_group = "yyHightlight", -- Default highlight group name
    highlight_color = "#1d23fb",       -- Default highlight color
    highlight_duration = 250        -- Default highlight duration in milliseconds (.25 seconds)
}

-- Function to allow users to configure the plugin
function M.setup(user_config)
    M.config = vim.tbl_extend("force", M.config, user_config)
end


M.highlight = function()
    local startPos = vim.api.nvim_buf_get_mark(0, "[")
    local endPos = vim.api.nvim_buf_get_mark(0, "]")

    -- Use the configured highlight group and color
    local highlightGroup = M.config.highlight_group
    vim.cmd("highlight " .. highlightGroup .. " guibg=" .. M.config.highlight_color)

    local ns_id = vim.api.nvim_create_namespace('yyHighlight')
    local buf = vim.api.nvim_get_current_buf()

    local startLine, startCol = startPos[1] - 1, 0
    local endLine = endPos[1] - 1
    local endLineText = vim.api.nvim_buf_get_lines(buf, endLine, endLine + 1, false)[1] or ""
    local endCol = #endLineText

    vim.api.nvim_buf_set_extmark(buf, ns_id, startLine, startCol, {
        end_line = endLine,
        end_col = endCol,
        hl_group = highlightGroup
    })

    -- Use the configured highlight duration
    vim.defer_fn(function()
        vim.api.nvim_buf_clear_namespace(buf, ns_id, 0, -1)
    end, M.config.highlight_duration)
end


-- Setup auto-command for TextYankPost
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        require'yyHighlight'.highlight()
    end,
})

return M
