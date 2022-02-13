local lapis = require("lapis")
local respond_to = require("lapis.application").respond_to
local app = lapis.Application()

categories = {"books", "games", "smartphones", "cameras", "vouchers"}
items = {"The Lord of The Rings", "Hamlet", "The Great Gatsby", "The Odyssey"}

app:get("/", function()
  return "Welcome to Lapis " .. require("lapis.version")
end)

app:match("/category", function(self)
  all = {}
  for i, cat in ipairs(categories) do
    table.insert(all, { id = i, category = categories[i] })
  end
  return { json = all }
end)

app:match("category", "/category/:id", respond_to({
  GET = function(self)
    return { json = { id = self.params.id, category = categories[tonumber(self.params.id)] } }
  end,
  DELETE = function(self)
    table.remove(categories, tonumber(self.params.id))
    return { json = { success = "true"} }
  end,
  POST = function(self)
    table.insert(categories, self.params.category)
    return { json = { success = "true" } }
  end,
  PUT = function(self)
    categories[self.params.id] = self.params.category
    return { json = { success = "true" } }
  end
}))



app:match("/item", function(self)
  all = {}
  for i, cat in ipairs(items) do
    table.insert(all, { id = i, item = items[i] })
  end
  return { json = all }
end)

app:match("item", "/item/:id", respond_to({
  GET = function(self)
    return { json = { id = self.params.id, item = items[tonumber(self.params.id)] } }
  end,
  DELETE = function(self)
    table.remove(items, tonumber(self.params.id))
    return { json = { success = "true"} }
  end,
  POST = function(self)
    table.insert(items, self.params.item)
    return { json = { success = "true" } }
  end,
  PUT = function(self)
    items[self.params.id] = self.params.item
    return { json = { success = "true" } }
  end
}))


return app