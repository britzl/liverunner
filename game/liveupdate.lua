local M = {}


function M.load_missing_resources(proxy, callback)
	local manifest = resource.get_current_manifest()

	local missing_resource_count = 0
	local missing_resources = collectionproxy.missing_resources(proxy)
	for k,v in pairs(missing_resources) do
		missing_resource_count = missing_resource_count + 1
	end
	
	if missing_resource_count > 0 then
		local http_request_count = missing_resource_count
		for _,resource_id in pairs(missing_resources) do
			local url = "http://127.0.0.1:8000/" .. resource_id
			http.request(url, "GET", function(self, id, response)
				if response.status == 200 then
					resource.store_resource(manifest, resource_id, response.response)
					missing_resource_count = missing_resource_count - 1
				end

				http_request_count = http_request_count - 1
				if http_requests == 0 then
					callback(missing_resource_count == 0)
				end
			end)
		end
	else
		callback(true)
	end
end

return M