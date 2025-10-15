return {
	"neovim/nvim-lspconfig",
	config = function()
		local lspconfig = require("lspconfig")
		local util = require("lspconfig.util")

		-- Improved root detection: only search upwards, no CWD fallback
		local function project_root(patterns)
			return function(fname)
				return util.root_pattern(unpack(patterns))(fname)
			end
		end

		-- Filter function to remove warnings
		local function filter_warnings(diagnostics)
			local filtered = {}
			for _, d in ipairs(diagnostics) do
				-- severity: 1 = Error, 2 = Warning, 3 = Info, 4 = Hint
				if d.severity ~= 2 then
					table.insert(filtered, d)
				end
			end
			return filtered
		end

		-- GDScript
		local port = os.getenv("GDScript_Port") or "6005"
		lspconfig.gdscript.setup({
			cmd = { "nc", "127.0.0.1", port },
			filetypes = { "gd", "gdscript", "gdscript3" },
			root_dir = project_root({ "project.godot", ".git" }),
			handlers = {
				["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
					if result.diagnostics then
						result.diagnostics = filter_warnings(result.diagnostics)
					end
					return vim.lsp.handlers["textDocument/publishDiagnostics"](_, result, ctx, config)
				end,
			},
		})

		-- TypeScript/JavaScript
		lspconfig.tsserver.setup({
			root_dir = project_root({ "package.json", "tsconfig.json", ".git" }),
		})

		-- Python
		lspconfig.pyright.setup({
			root_dir = project_root({ "pyproject.toml", "setup.py", ".git" }),
		})

		-- C# (OmniSharp)
		lspconfig.omnisharp.setup({
			cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
			root_dir = project_root({ "*.sln", "*.csproj", "omnisharp.json", "function.json", "project.godot" }),
			filetypes = { "cs" },
			init_options = {},
			settings = {
				FormattingOptions = {
					EnableEditorConfigSupport = true,
					OrganizeImports = true,
				},
				MsBuild = {
					LoadProjectsOnDemand = false,
				},
				RoslynExtensionsOptions = {
					EnableAnalyzersSupport = true,
					EnableImportCompletion = true,
					AnalyzeOpenDocumentsOnly = false,
				},
				Sdk = {
					IncludePrereleases = true,
				},
			},
			env = {
				DOTNET_CLI_UI_LANGUAGE = "en",
				LANG = "en_US.UTF-8",
				LC_ALL = "en_US.UTF-8",
			},
		})
	end,
}
