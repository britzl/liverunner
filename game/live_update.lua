local M = {}

M.RESOURCES_MISSING = hash("resources_missing")
M.RESOURCES_LOADED = hash("resources_loaded")
M.RESOURCES_PROGRESS = hash("resources_progress")

function M.missing_resource_count(proxy)
	return #collectionproxy.missing_resources(proxy)
end

function M.load_missing_resources(proxy, url)
	assert(proxy, "You must provide a proxy")
	assert(url, "You must provide a URL")

	local missing_resources = collectionproxy.missing_resources(proxy)
	local missing_resource_count = #missing_resources

	if missing_resource_count > 0 then
		local manifest = resource.get_current_manifest()
		local http_request_count = missing_resource_count
		
		local function http_request_done()
			http_request_count = http_request_count - 1
			if http_request_count == 0 then
				if missing_resource_count == 0 then
					msg.post("#", M.RESOURCES_LOADED, { proxy = proxy })
				else
					msg.post("#", M.RESOURCES_MISSING, { proxy = proxy, count = missing_resource_count })
				end
			end
		end

		local bytes = 0
		for _,hexdigest in pairs(missing_resources) do
			http.request(url .. hexdigest, "GET", function(self, id, response)
				if response.status == 200 then
					bytes = bytes + #response.response
					msg.post("#", M.RESOURCES_PROGRESS, { proxy = proxy, bytes = bytes })
					resource.store_resource(manifest, response.response, hexdigest, function(self, hexdigest, status)
						print("stored", hexdigest, status)
						if status then
							missing_resource_count = missing_resource_count - 1
						end
						http_request_done()
					end)
				else
					http_request_done()
				end
			end)
		end
	else
		msg.post("#", M.RESOURCES_LOADED, { proxy = proxy })
	end
end

return M