local M = {}

-- Default configuration
M.config = {
    highlight_group = "yyHightlight", -- Default highlight group name
    highlight_color = "#4c4e90",       -- Default highlight color
    highlight_duration = 250        -- Default highlight duration in milliseconds (.25 seconds)
}

-- Function to allow users to configure the plugin
function M.setup(user_config)
    M.config = vim.tbl_extend("force", M.config, user_config)
end

M.highlight = function()
    local buf = vim.api.nvim_get_current_buf()
    local ns_id = vim.api.nvim_create_namespace('yyHighlight')

    -- Consolidate retrieval of start and end positions to reduce calls
    local startPos, endPos = vim.api.nvim_buf_get_mark(buf, "["), vim.api.nvim_buf_get_mark(buf, "]")

    -- Directly use 'M.config' table to access configurations
    -- Combine highlight setup into one command if possible and check if highlight group needs to be redefined
    local highlightGroup = M.config.highlight_group
    local highlightCmd = string.format("highlight %s guibg=%s", highlightGroup, M.config.highlight_color)
    vim.cmd(highlightCmd)

    -- Adjust line and column numbers for zero-based indexing and inclusive highlighting
    local startLine, startCol = startPos[1] - 1, startPos[2]
    local endLine, endCol = endPos[1] - 1, endPos[2] + 1 -- Make endCol inclusive in the highlight

    -- Adjust endCol based on the length of the end line to ensure it doesn't exceed the line length
    local endLineText = vim.api.nvim_buf_get_lines(buf, endLine, endLine + 1, false)[1]
    endCol = math.min(endCol, #endLineText) -- Ensure endCol does not exceed line length

    -- Set the highlight and use table to pass parameters for clarity
    vim.api.nvim_buf_set_extmark(buf, ns_id, startLine, startCol, {
        end_line = endLine,
        end_col = endCol,
        hl_group = highlightGroup,
    })

    -- Clear the highlight after a delay, using 'M.config.highlight_duration'
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
