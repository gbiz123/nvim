local function ends_with(str, ending)
   return ending == "" or str:sub(-#ending) == ending
end

local function buf_is_java(buf)
	local buf_name = vim.api.nvim_buf_get_name(buf)
	print(buf_name)
	if ends_with(buf_name, '.java') then
		return true
	else
		return false
	end
end

local function update_references()
	
end

local function print_bufs()
	local bufs = vim.api.nvim_list_bufs()
	for _, buf in ipairs(bufs) do
		local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
		if not buf_is_java(buf) then
			goto continue
		end
		for _, line in ipairs(lines) do
			print(line)
		end
	    ::continue::
	end
end

-- print_bufs()

-- vim.api.nvim_create_autocmd({"BufAdd"}, {
-- 	pattern = {"*.java"},
-- 	callback = function (args)
-- 		print_bufs()
-- 	end
-- })
-- vim.api.nvim_create_user_command("Bonk", function () print_bufs() end, {})
