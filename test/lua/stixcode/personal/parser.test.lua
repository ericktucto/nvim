local parser = require("stixcode.personal.parser")

describe("parser.dump format table to json", function ()
  it("basic array values", function ()
    local expected = "[\n" .. [[
  1,
  2,
  3
]] .. "]"
    local json = { 1, 2, 3 }
    assert.equals(expected, parser.dump(json))
  end)
  it("basic json values", function ()
    local expected = [[{
  "name": "erick tucto"
}]]
    local json = { name = "erick tucto" }
    assert.equals(expected, parser.dump(json))
  end)
  it("object with array numbers", function ()
    local expected = [[{
  "numbers": [
    1,
    2,
    3
  ]
}]]
    local json = { numbers = { 1, 2, 3 } }
    assert.equals(expected, parser.dump(json))
  end)
  it("array of objects", function ()
    local expected = "[\n" .. [[
  {
    "name": "erick"
  }
]] .. "]"
    local json = { { name = "erick" } }
    assert.equals(expected, parser.dump(json))
  end)
end)
describe("parser.ptype get printed type", function ()
  local dataProviderTypes = {
    { title = "string",  input = "is string",        expected = "\"is string\"" },
    { title = "vim.NIL", input = vim.NIL,            expected = "null" },
    { title = "number",  input = 400,                expected = 400 },
    { title = "array",   input = { 1, 2, 3 },        expected = "[" },
    { title = "object",  input = { name = "erick" }, expected = "{" },
    { title = "boolean", input = true,               expected = "true" },
    { title = "boolean", input = false,              expected = "false" },
  }
  for _, data in ipairs(dataProviderTypes) do
    local title_test = "print data type: " .. data.title
    it(title_test, function ()
      local actual = parser.ptype(data.input)
      assert.equals(data.expected, actual)
    end)
  end
end)
