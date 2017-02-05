local M = {}


function M.load_collection(proxy, callback)
	local manifest = resource.get_current_manifest()
	local http_requests = 0
	local resource_count = 0

	local missing_resources = collectionproxy.missing_resources(proxy)
	if #missing_resources > 0 then
		http_requests = #missing_resources
		resource_count = #missing_resources
		for k, v in pairs(missing_resources) do
			local url = "http://example.com/defold/" .. v
			http.request(url, "GET", function(self, id, response)
				if response.status == 200 then
					if resource.verify_resource(manifest, response.response) then
						resource.store_resource(response.response)
						resource_count = resource_count - 1
					else
						-- The resource was corrupted during transmission
					end
				else
					-- The download did not succeed
				end
				
				http_requests = http_requests - 1
				if http_requests == 0 then
					-- All requests to download resources have been completed
					if resource_count == 0 then
						-- We are ready to load the collectionproxy
						msg.post(proxy, "load")
					else
						-- We've failed to download one or more resource(s)
					end
				end
				
			end)
		end
	else
		msg.post(proxy, "load")
	end

end

return M