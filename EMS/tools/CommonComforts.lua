function AddTribute( _tribute )
	assert( type( _tribute ) == "table", "Tribut muß ein Table sein" );
	assert( type( _tribute.text ) == "string", "Tribut.text muß ein String sein" );
	assert( type( _tribute.cost ) == "table", "Tribut.cost muß ein Table sein" );
	assert( type( _tribute.pId ) == "number", "Tribut.pId muß eine Nummer sein" );
	assert( not _tribute.Tribute , "Tribut.Tribute darf nicht vorbelegt sein");

	uniqueTributeCounter = uniqueTributeCounter or 1;
	_tribute.Tribute = uniqueTributeCounter;
	uniqueTributeCounter = uniqueTributeCounter + 1;

	local tResCost = {};
	for k, v in pairs( _tribute.cost ) do
		assert( ResourceType[k] );
		assert( type( v ) == "number" );
		table.insert( tResCost, ResourceType[k] );
		table.insert( tResCost, v );
	end

	Logic.AddTribute( _tribute.pId, _tribute.Tribute, 0, 0, _tribute.text, unpack( tResCost ) );
	SetupTributePaid( _tribute );
	return _tribute.Tribute;
end