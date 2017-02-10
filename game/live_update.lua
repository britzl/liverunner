local M = {}

function M.missing_resource_count(proxy)
	return #collectionproxy.missing_resources(proxy)
end

function M.load_missing_resources(proxy, url, callback)
	assert(proxy, "You must provide a proxy")
	assert(url, "You must provide a URL")

	local missing_resources = collectionproxy.missing_resources(proxy)
	local total = #missing_resources
	local failed = 0
	local loaded = 0
	local bytes = 0

	local function update_status()
		local done = (failed + loaded) == total
		print("sending status", done, failed, loaded, bytes, total)
		callback({
			proxy = proxy,
			bytes = bytes,
			failed = failed,
			loaded = loaded,
			total = total,
			done = done})
	end

	if #missing_resources > 0 then
		local manifest = resource.get_current_manifest()

		for _,hexdigest in pairs(missing_resources) do
			http.request(url .. hexdigest, "GET", function(self, id, response)
				if response.status == 200 then
					bytes = bytes + #response.response
					update_status()
					resource.store_resource(manifest, response.response, hexdigest, function(self, hexdigest, status)
						print("stored", hexdigest, status)
						if status then
							loaded = loaded + 1
						else
							failed = failed + 1
						end
						update_status()
					end)
				else
					failed = failed + 1
					update_status()
				end
			end)
		end
	else
		update_status()
	end
end

return M