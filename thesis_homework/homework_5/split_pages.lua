local figure_count = 0
local table_count = 0
local first_header = true

-- Helper function to extract content from a specific raw block tag (for table source)
-- function extract_raw_metadata(blocks)
--     for i, block in ipairs(blocks) do
--         if block.tag == 'RawBlock' and block.format == 'tex' then
--             local text = block.text
--             -- Look for \rawtablemetadata{...} and capture the content
--             local start_pos, end_pos, metadata = string.find(text, '\\rawtablemetadata%s*{%s*(.-)%s*}')
--             if metadata then
--                 -- Remove the metadata block from the stream so it isn't rendered twice
--                 blocks[i] = pandoc.Div(nil, {}) 
--                 return metadata
--             end
--         end
--     end
--     -- Default source if not found
--     return "Allikas: Puudub andmete kirjeldus"
-- end

function Header(el)
  if el.level == 2 then
    if first then
      first = false
      return el
    else
      return { pandoc.RawBlock("latex", "\\clearpage"), el }
    end
  end
end


function Blocks(blocks)
    local new_blocks = {}
    -- local table_metadata = extract_raw_metadata(blocks)
    local is_in_figure = false 

    for i, block in ipairs(blocks) do

        -- 1. DEDICATED BLOCK FILTERING FOR REDUNDANT CAPTION PARAGRAPH
        if block.tag == 'Para' and string.match(pandoc.utils.stringify(block), '^Tabel: ') then
            -- This skips the redundant paragraph "Tabel: Rakenduse..."
            -- We do nothing, effectively skipping the block.
            
        -- 2. Check for the start of a figure (an Image block)
        elseif block.tag == 'Para' and #block.content > 0 and block.content[1].tag == 'Image' then
            
            figure_count = figure_count + 1
            is_in_figure = true
            
            -- Inject \begin{figure}
            table.insert(new_blocks, pandoc.RawBlock("latex", "\\begin{figure}[htbp]\\centering"))
            table.insert(new_blocks, block) -- The image itself

        -- elseif block.tag == 'Table' then
            
        --     table_count = table_count + 1
        --     local table_label = "tab:" .. table_count
        --     local caption_text = pandoc.utils.stringify(block.caption)
            
        --     -- Inject \begin{table}, the caption, and the table body
        --     table.insert(new_blocks, pandoc.RawBlock("latex", "\\begin{table}[htbp]\\centering"))
            
        --     -- Use \tablename command for language independence
        --     local caption_code = string.format(
        --         "\\caption{\\textbf{\\tablename\\ %s.} %s}\\label{%s}",
        --         table_count, caption_text, table_label
        --     )
        --     table.insert(new_blocks, pandoc.RawBlock("latex", caption_code))
        --     table.insert(new_blocks, block) -- Inject the table itself
            
        --     -- Inject the dynamic source note and end the table
        --     local source_code = pandoc.RawBlock("latex", 
        --         string.format("\\par\\noindent\\footnotesize\\emph{%s}\\end{table}", table_metadata)
        --     )
        --     table.insert(new_blocks, source_code)
            
        -- If none of the above, just keep the block
        else
            table.insert(new_blocks, block)
        end
    end
    return new_blocks
end