
			<cfset this[ "isFemale" ] = variables[ "isFemale" ]> 
			<cffunction name="isFemale" access="public" output="false" returntype="boolean">

			<cfset var results = this._mockResults>
			<cfset var resultsKey = "isFemale">
			<cfset var resultsCounter = 0>
			<cfset var internalCounter = 0>
			<cfset var resultsLen = 0>
			<cfset var callbackLen = 0>
			<cfset var argsHashKey = resultsKey & "|" & this.mockBox.normalizeArguments( arguments )>
			<cfset var fCallBack = "">
			
			<!--- If Method & argument Hash Results, switch the results struct --->
			<cfif structKeyExists( this._mockArgResults, argsHashKey )>
				<!--- Check if it is a callback --->
				<cfif isStruct( this._mockArgResults[ argsHashKey ] ) and 
					  structKeyExists( this._mockArgResults[ argsHashKey ], "type" ) and
					  structKeyExists( this._mockArgResults[ argsHashKey ], "target" )>
					<cfset fCallBack = this._mockArgResults[ argsHashKey ].target>
				<cfelse>
					<!--- switch context and key --->
					<cfset results = this._mockArgResults>
					<cfset resultsKey = argsHashKey>
				</cfif>
			</cfif>
			
			<!--- Get the statemachine counter --->
			<cfif isSimpleValue( fCallBack )>
				<cfset resultsLen = arrayLen( results[ resultsKey ] )>
			</cfif>

			<!--- Get the callback counter, if it exists --->
			<cfif structKeyExists( this._mockCallbacks, resultsKey )>
				<cfset callbackLen = arrayLen( this._mockCallbacks[ resultsKey ] )>
			</cfif>
			
			<!--- Log the Method Call --->
			<cfset this._mockMethodCallCounters[ listFirst( resultsKey, "|" ) ] = this._mockMethodCallCounters[ listFirst( resultsKey, "|" ) ] + 1>
			
			<!--- Get the CallCounter Reference --->
			<cfset internalCounter = this._mockMethodCallCounters[listFirst(resultsKey,"|")]>
			<cfset arrayAppend(this._mockCallLoggers["isFemale"], arguments)>

				<cfif resultsLen neq 0>
					<cfif internalCounter gt resultsLen>
						<cfset resultsCounter = internalCounter - ( resultsLen*fix( (internalCounter-1)/resultsLen ) )>
						<cfreturn results[resultsKey][resultsCounter]>
					<cfelse>
						<cfreturn results[resultsKey][internalCounter]>
					</cfif>
				</cfif>
				
				<cfif callbackLen neq 0>
					<cfset fCallBack = this._mockCallbacks[ resultsKey ][ 1 ]>
					<cfreturn fCallBack()>
				</cfif>
				
				<cfif not isSimpleValue( fCallBack )>
					<cfreturn fCallBack()>
				</cfif>
				</cffunction>
