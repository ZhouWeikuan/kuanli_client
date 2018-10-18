PATCH_NAME = "MyGame1.0.0"

cc.FileUtils:getInstance():setPopupNotify(false)

local patchPath = cc.FileUtils:getInstance():getWritablePath() .. PATCH_NAME .. "/"
cc.FileUtils:getInstance():addSearchPath(patchPath, true)

local path = {
    "script",
    "script/app",
    "script/app/Helpers",
    "script/app/Algos",
    "script/app/Classes",
    "script/app/Stages",
    "script/app/utils",
    "script/app/views",
    "src",
    "res",
    "res/all",
    "res/both"
}
for i, p in ipairs(path) do
    cc.FileUtils:getInstance():addSearchPath(patchPath .. p)
    cc.FileUtils:getInstance():addSearchPath(p)
end

local one = patchPath .. "src"
local str = string.format("%s/?.lua;", one)
str = str .. "?.lua;"

package.path = package.path .. str

cc.prev_loaded = {}
for k, v in pairs(package.loaded) do
    cc.prev_loaded[k] = v
end

require "config"
require "cocos.init"

local function main()
    require("app.MyApp"):create():run()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
