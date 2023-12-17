workspace "WorkTimeTracker"
	platforms "x64"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

	outputs  = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

	-- Include directories relative to root folder (solution directory)
	IncludeDir = {}
	IncludeDir["GLFW"] = "WorkTimeTracker/vendor/GLFW/include"
	IncludeDir["glad"] = "WorkTimeTracker/vendor/glad/include"
	IncludeDir["ImGui"] = "WorkTimeTracker/vendor/ImGui"

	include "WorkTimeTracker/vendor/GLFW"
	include "WorkTimeTracker/vendor/glad"
	include "WorkTimeTracker/vendor/ImGui"

project "WorkTimeTracker"
	location "WorkTimeTracker"
	kind "ConsoleApp"
	language "C++"

	targetdir ("bin/" .. outputs  .. "/%{prj.name}")
	objdir ("bin-int/" .. outputs  .. "/%{prj.name}")

	pchheader "core/pch.h"
	pchsource "WorkTimeTracker/src/core/pch.cpp"

	files
    {
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"%{prj.name}/src",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.glad}",
		"%{IncludeDir.ImGui}"
	}
	
	links 
	{ 
		"GLFW",
		"glad",
		"ImGui",
		"opengl32.lib"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"GL_PLATFORM_WINDOWS",
			"GLFW_INCLUDE_NONE"
		}

	filter "configurations:Debug"
		defines "GL_DEBUG"
		buildoptions "/MDd"
		symbols "On"

	filter "configurations:Release"
		defines "GL_RELEASE"
		buildoptions "/MD"
		optimize "On"

	filter "configurations:Dist"
		defines "GL_DIST"
		buildoptions "/MD"
		optimize "On"
