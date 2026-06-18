local jdtls = require 'jdtls'

-- Workspace directory per project
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath 'data' .. '/jdtls-workspace/' .. project_name

-- Find jdtls install path via Mason
local mason_registry = require 'mason-registry'

local jdtls_path = mason_registry.get_package('jdtls'):get_install_path()
local launcher = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')
local config_dir = jdtls_path .. '/config_mac' -- change to config_linux on Linux

-- Extended capabilities for nvim-jdtls
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- Debug bundles
local bundles = {}

local java_debug_path = mason_registry.get_package('java-debug-adapter'):get_install_path()
local java_debug_jar = vim.fn.glob(java_debug_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar', true)
if java_debug_jar ~= '' then
  vim.list_extend(bundles, { java_debug_jar })
end

local java_test_path = mason_registry.get_package('java-test'):get_install_path()
local java_test_jars = vim.split(vim.fn.glob(java_test_path .. '/extension/server/*.jar', true), '\n')
if java_test_jars[1] ~= '' then
  vim.list_extend(bundles, java_test_jars)
end

local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', launcher,
    '-configuration', config_dir,
    '-data', workspace_dir,
  },

  root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' },

  settings = {
    java = {
      signatureHelp = { enabled = true },
      import = { enabled = true },
      rename = { enabled = true },
      completion = {
        favoriteStaticMembers = {
          'org.hamcrest.MatcherAssert.assertThat',
          'org.hamcrest.Matchers.*',
          'org.hamcrest.CoreMatchers.*',
          'org.junit.jupiter.api.Assertions.*',
          'java.util.Objects.requireNonNull',
          'java.util.Objects.requireNonNullElse',
          'org.mockito.Mockito.*',
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
    },
  },

  init_options = {
    bundles = bundles,
    extendedClientCapabilities = extendedClientCapabilities,
  },

  on_attach = function(_, bufnr)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'Java: ' .. desc })
    end

    -- jdtls specific actions
    map('<leader>co', jdtls.organize_imports, 'Organize Imports')
    map('<leader>cv', jdtls.extract_variable, 'Extract Variable')
    map('<leader>cc', jdtls.extract_constant, 'Extract Constant')
    vim.keymap.set('v', '<leader>cm', function() jdtls.extract_method(true) end, { buffer = bufnr, desc = 'Java: Extract Method' })

    -- Debug/Test
    map('<leader>ct', jdtls.test_class, 'Test Class')
    map('<leader>cn', jdtls.test_nearest_method, 'Test Nearest Method')

    -- Setup DAP after jdtls attaches
    jdtls.setup_dap { hotcodereplace = 'auto' }
  end,
}

jdtls.start_or_attach(config)

-- vim: ts=2 sts=2 sw=2 et
