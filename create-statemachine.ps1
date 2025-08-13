param(
	[string] $Name,
	[string] $ParentDir,
	[string[]] $InitialStates = @("Disabled", "Enabled"),

	[ValidateSet("Node", "Node2D", "Control")]
	[string] $BaseType = "Node"
)

function PascalToSnake([string] $Value) {
	if ([Regex]::Match($Value, '^[A-Z]+$').Success) {
		return $Value.ToLower()
	}

	# taken from https://gist.github.com/awakecoding/acc626741704e8885da8892b0ac6ce64
	return [Regex]::Replace($Value, '(?<=.)(?=[A-Z])', '_').ToLower()
}

function MakePath([string] $RawPath) {
	# this ensures path resolution works on Windows and macOS
	return Join-Path (Resolve-Path .) $RawPath
}

function CreateStateFile([string] $StateName) {
	$machinePrefix = PascalToSnake -Value $Name
	$stateNameLower = $StateName.ToLower()

	$stateFileName = "$($machinePrefix)_state_$($stateNameLower).gd"
	$stateFilePath = MakePath -RawPath "$ParentDir\$baseDir\$statesDir\$stateFileName"

	Write-Host "Writing $stateNameLower state file '$stateFileName'..."

	[IO.File]::WriteAllLines(
		$stateFilePath,
		[string[]]@(
			"class_name $($Name)State$($StateName)",
			"extends $($Name)State",
			"",
			"func _enter_tree() -> void:"
				"`tprint(`"%s is now $($stateNameLower)`" % _$($fieldName).name)"
		)
	)
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

$stateNamesUpper = [string[]]($InitialStates | % {
	return $_.ToUpper()
})

$firstStateNameUpper = $stateNamesUpper[0]

$stateEnumStr = $stateNamesUpper -join ", "

[IO.File]::WriteAllLines(
	$baseFilePath,
	[string[]]@(
		"class_name $Name",
		"extends $BaseType",
		"",
		"enum State { $stateEnumStr }",
		"",
		"var _state_factory := $($Name)StateFactory.new()",
		"var _current_state: $($Name)State = null",
		"",
		"func _ready() -> void:",
			"`tswitch_state($($Name).State.$($firstStateNameUpper))",
		"",
		"func switch_state(state: State, state_data := $($Name)StateData.new()) -> void:",
			"`tif _current_state != null:",
				"`t`t_current_state.queue_free()",
		"",
			"`t_current_state = _state_factory.get_fresh_state(state)",
		"",
			"`t_current_state.setup(",
				"`t`tself,",
				"`t`tstate_data)"
		"",
			"`t_current_state.state_transition_requested.connect(switch_state)",
			"`t_current_state.name = `"$($Name)StateMachine: %s`" % str(state)",
		"",
			"`tcall_deferred(`"add_child`", _current_state)"
	)
)

$stateFactoryFileName = "$(PascalToSnake -Value $Name)_state_factory.gd"
$stateFactoryFilePath = MakePath -RawPath "$ParentDir\$baseDir\$stateFactoryFileName"

Write-Host "Writing state factory file '$stateFactoryFileName'..."

$statesDictLines = [string[]]($InitialStates | % {
	return "`t`t$($Name).State.$($_.ToUpper()): $($Name)State$($_),"
})

[IO.File]::WriteAllLines(
	$stateFactoryFilePath,
	[string[]]@(
		"class_name $($Name)StateFactory",
		"",
		"var states: Dictionary",
		"",
		"func _init() -> void:",
		"`tstates = {"
	) +
	$statesDictLines +
	[string[]]@(
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

$InitialStates | % {
	CreateStateFile -StateName $_
}
