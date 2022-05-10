obs = obslua

stream_started_at_seconds = nil
output_path = ""

function get_current_scene_name()
	local scene = obs.obs_frontend_get_current_scene()
	local scene_name = obs.obs_source_get_name(scene)
	obs.obs_source_release(scene)
	return scene_name
end

function format_chapter_line(scene_name, elapsed_seconds)
	local seconds = math.floor(elapsed_seconds % 60)
	local minutes = math.floor(elapsed_seconds / 60)
	local hours = math.floor(elapsed_seconds / 3600)
	return string.format("%02d:%02d:%02d %s", hours, minutes, seconds, scene_name)
end

function write_chapter_line(elapsed_seconds)
	local line = format_chapter_line(get_current_scene_name(), elapsed_seconds)
	io.write(line, "\n")
	print(line)
end

function on_obs_frontend_event(event)
	if event == obs.OBS_FRONTEND_EVENT_STREAMING_STARTED then
		on_obs_frontend_event_streaming_started()
	end

	if event == obs.OBS_FRONTEND_EVENT_STREAMING_STOPPED then
		on_obs_frontend_event_streaming_stopped()
	end

	if event == obs.OBS_FRONTEND_EVENT_SCENE_CHANGED then
		on_obs_frontend_event_scene_changed()
	end
end

function on_obs_frontend_event_scene_changed()
	if stream_started_at_seconds == nil then
		return
	end

	write_chapter_line(os.difftime(os.time(), stream_started_at_seconds))
end

function on_obs_frontend_event_streaming_started()
	stream_started_at_seconds = os.time()

	if output_path ~= "" then
		io.output(output_path)
	end

	write_chapter_line(0)
end

function on_obs_frontend_event_streaming_stopped()
	stream_started_at_seconds = nil

	if output_path ~= "" then
		io.close()
	end
end

-- OBS callback.
function script_properties()
	local props = obs.obs_properties_create()
	obs.obs_properties_add_path(props, "output_path", "Output path", obs.OBS_PATH_FILE, "text file (*.txt)", nil)
	return props
end

-- OBS callback.
function script_update(settings)
	output_path = obs.obs_data_get_string(settings, "output_path")
end

-- OBS callback.
function script_load(settings)
	obs.obs_frontend_add_event_callback(on_obs_frontend_event)
end

-- OBS callback.
function script_description()
	return "Generate YouTube chapter file according to the switched scenes."
end
