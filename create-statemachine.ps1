param(
	[string] $Name,
	[string] $ParentDir
)

function PascalToSnake([string] $Value) {
	# taken from https://gist.github.com/awakecoding/acc626741704e8885da8892b0ac6ce64
	return [Regex]::Replace($Value, '(?<=.)(?=[A-Z])', '_').ToLower()
}

function MakePath([string] $RawPath) {
	# this ensures path resolution works on Windows and macOS
	return Join-Path (Resolve-Path .) $RawPath
}

if (-not $Name) {
	Write-Error "Please provide a name for the machine!"
	return
}

Write-Host "Generating new state machine for '$Name'..."

$baseDir = PascalToSnake -Value $Name

mkdir (MakePath -RawPath "$ParentDir\$baseDir") | Out-Null

$baseFileName = "$(PascalToSnake -Value $Name).gd"
$baseFilePath = MakePath -RawPath "$ParentDir\$baseDir\$baseFileName"

Write-Host "Writing base file '$baseFileName'..."

[IO.File]::WriteAllLines(
	$baseFilePath,
	[string[]]@(
		"class_name $Name",
		"extends Node",
		"",
		"enum State { ENABLED }"
		)
		)

$stateFactoryFileName = "$(PascalToSnake -Value $Name)_state_factory.gd"
$stateFactoryFilePath = MakePath -RawPath "$ParentDir\$baseDir\$stateFactoryFileName"

Write-Host "Writing state factory file '$stateFactoryFileName'..."

[IO.File]::WriteAllLines(
	$stateFactoryFilePath,
	[string[]]@(
		"class_name $($Name)StateFactory",
		"",
		"var states: Dictionary",
		"",
		"func _init() -> void:",
		"`tstates = {",
		"`t`t$($Name).State.ENABLED: $($Name)StateEnabled,",
		"`t}",
		"",
		"func get_fresh_state(state: $($Name).State) -> $($Name)State:",
		"`tassert(states.has(state), `"State is missing!`")",
		"`treturn states.get(state).new()"
	)
)

$statesDir = "states"

mkdir (MakePath -RawPath "$ParentDir\$baseDir\$statesDir") | Out-Null

$stateDataFileName = "$(PascalToSnake -Value $Name)_state_data.gd"
$stateDataFilePath = MakePath -RawPath "$ParentDir\$baseDir\$statesDir\$stateDataFileName"

Write-Host "Writing state data file '$stateDataFileName'..."

[IO.File]::WriteAllLines(
	$stateDataFilePath,
	[string[]]@(
		"class_name $($Name)StateData",
		"",
		"static func build() -> $($Name)StateData:",
			"`treturn $($Name)StateData.new()"
	)
)

$baseStateFileName = "$(PascalToSnake -Value $Name)_state.gd"
$baseStateFilePath = MakePath -RawPath "$ParentDir\$baseDir\$statesDir\$baseStateFileName"

Write-Host "Writing base state file '$baseStateFileName'..."

$fieldName = PascalToSnake -Value $Name

[IO.File]::WriteAllLines(
	$baseStateFilePath,
	[string[]]@(
		"class_name $($Name)State",
		"extends Node",
		""
		"signal state_transition_requested(new_state: $($Name).State, state_data: $($Name)StateData)"
		""
		"var _$($fieldName): $($Name) = null"
		"var _state_data: $($Name)StateData = null"
		""
		"func setup("
		"`t$($fieldName): $($Name),"
		"`tstate_data: $($Name)StateData,"
		") -> void:"
		"`t_$($fieldName) = $($fieldName)"
		"`t_state_data = state_data"
		""
		"func transition_state("
		"`tnew_state: $($Name).State,"
		"`tstate_data := $($Name)StateData.new(),"
		") -> void:"
		"`tstate_transition_requested.emit(new_state, state_data)"
	)
)

$enabledStateFileName = "$(PascalToSnake -Value $Name)_state_enabled.gd"
$enabledStateFilePath = MakePath -RawPath "$ParentDir\$baseDir\$statesDir\$enabledStateFileName"

Write-Host "Writing enabled state file '$enabledStateFileName'..."

[IO.File]::WriteAllLines(
	$enabledStateFilePath,
	[string[]]@(
		"class_name $($Name)StateEnabled",
		"extends $($Name)State",
		"",
		"func _enter_tree() -> void:"
			"`tprint(`"$Name is now enabled`")"
	)
)
