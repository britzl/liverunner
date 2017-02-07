local M = {}


function M.load_missing_resources(proxy)
	local manifest = resource.get_current_manifest()

	local missing_resources = collectionproxy.missing_resources(proxy)
	pprint(missing_resources)
	local missing_resource_count = #missing_resources

	if missing_resource_count > 0 then
		print("There are missing resources", missing_resource_count)
		local http_request_count = missing_resource_count
		
		local function http_request_done()
			http_request_count = http_request_count - 1
			print("http_request_done", http_request_count)
			if http_request_count == 0 then
				print("all requests done")
				if missing_resource_count == 0 then
					print("no missing resources")
					msg.post("#", "resources_loaded", { proxy = proxy })
				else
					print("missing resources")
					msg.post("#", "resources_missing", { proxy = proxy })
				end
			end
		end

		for _,hexdigest in pairs(missing_resources) do
			local url = "http://127.0.0.1:8000/" .. hexdigest
			print("getting", url)
			http.request(url, "GET", function(self, id, response)
				if response.status == 200 then
					print("got http response, storing")
					resource.store_resource(manifest, response.response, hexdigest, function(self, hexdigest, status)
						print("stored", hexdigest, status)
						if status then
							missing_resource_count = missing_resource_count - 1
						end
						http_request_done()
					end)
				else
					print("got http response", response.status)
					http_request_done()
				end
			end)
		end
	else
		msg.post("#", "resources_loaded", { proxy = proxy })
	end
end

return M