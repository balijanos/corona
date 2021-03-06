//////////////////////////////////////////////////////////////////////////////
//
// Copyright (C) 2018 Corona Labs Inc.
// Contact: support@coronalabs.com
//
// This file is part of the Corona game engine.
//
// Commercial License Usage
// Licensees holding valid commercial Corona licenses may use this file in
// accordance with the commercial license agreement between you and 
// Corona Labs Inc. For licensing terms and conditions please contact
// support@coronalabs.com or visit https://coronalabs.com/com-license
//
// GNU General Public License Usage
// Alternatively, this file may be used under the terms of the GNU General
// Public license version 3. The license is as published by the Free Software
// Foundation and appearing in the file LICENSE.GPL3 included in the packaging
// of this file. Please review the following information to ensure the GNU 
// General Public License requirements will
// be met: https://www.gnu.org/licenses/gpl-3.0.html
//
// For overview and more information on licensing please refer to README.md
//
//////////////////////////////////////////////////////////////////////////////

#import "TestAppLibraryModule.h"

#import "CoronaRuntime.h"
#import <UIKit/UIKit.h>

// ----------------------------------------------------------------------------

static int
printRuntime( lua_State *L )
{
	id<CoronaRuntime> runtime = (id<CoronaRuntime>)lua_touserdata( L, lua_upvalueindex( 1 ) );

	NSLog( @"%@", runtime );

	return 0;
}

// ----------------------------------------------------------------------------

const char *
TestAppLibraryModule::Name()
{
	static const char sName[] = "testapp";
	return sName;
}

int
TestAppLibraryModule::Open( lua_State *L )
{
	const luaL_Reg kVTable[] =
	{
		{ "printRuntime", printRuntime },

		{ NULL, NULL }
	};

	// Ensure upvalue is available to library
	void *context = lua_touserdata( L, lua_upvalueindex( 1 ) );
	lua_pushlightuserdata( L, context );

	luaL_openlib( L, Name(), kVTable, 1 ); // leave "mylibrary" on top of stack

	return 1;
}

// ----------------------------------------------------------------------------

