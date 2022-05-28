local options = {
	compatible = false,
	ignorecase = true,
	number = true,
	relativenumber = true,
	ruler = true,
	tabstop = 2,
	updatetime = 1000,
}
for k, v in pairs(options) do
	vim.opt[k] = v
end
