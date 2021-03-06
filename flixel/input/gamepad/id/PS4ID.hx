package flixel.input.gamepad.id;

import flixel.input.gamepad.FlxGamepad;

/**
 * IDs for PlayStation 4 controllers
 * (D-pad values are obtained from FlxGamepad.hat)
 */
class PS4ID
{
	//These values have only been tested on WINDOWS!
	
#if flash
	
	public static inline var SQUARE:Int = 10;
	public static inline var X:Int = 11;
	public static inline var CIRCLE:Int = 12;
	public static inline var TRIANGLE:Int = 13;
	public static inline var L1:Int = 14;
	public static inline var R1:Int = 15;
	public static inline var L2:Int = 16;
	public static inline var R2:Int = 17;
	public static inline var SHARE:Int = 18;
	public static inline var OPTIONS:Int = 19;
	public static inline var LEFT_STICK_CLICK:Int = 20;
	public static inline var RIGHT_STICK_CLICK:Int = 21;
	public static inline var PS:Int = 22;
	public static inline var TOUCHPAD_CLICK:Int = 23;
	
	public static var LEFT_ANALOG_STICK(default, null) = new FlxGamepadAnalogStick(0 , 1);
	public static var RIGHT_ANALOG_STICK(default, null) = new FlxGamepadAnalogStick(2, 5);
	
	public static inline var DPAD_UP:Int = 6;
	public static inline var DPAD_DOWN:Int = 7;
	public static inline var DPAD_LEFT:Int = 8;
	public static inline var DPAD_RIGHT:Int = 9;
	
#elseif !FLX_JOYSTICK_API		//"next"
	
	public static inline var X:Int = 6;
	public static inline var CIRCLE:Int = 7;
	public static inline var SQUARE:Int = 8;
	public static inline var TRIANGLE:Int = 9;
	public static inline var SHARE:Int = 10;
	public static inline var PS:Int = 11;
	public static inline var OPTIONS:Int = 12;
	public static inline var LEFT_STICK_CLICK:Int = 13;
	public static inline var RIGHT_STICK_CLICK:Int = 14;
	public static inline var L1:Int = 15;
	public static inline var R1:Int = 16;
	
	public static inline var TOUCHPAD_CLICK:Int = 21;
	
	public static var LEFT_ANALOG_STICK(default, null) = new FlxGamepadAnalogStick(0, 1);
	public static var RIGHT_ANALOG_STICK(default, null) = new FlxGamepadAnalogStick(2, 3);
	
	public static inline var L2:Int = 4;
	public static inline var R2:Int = 5;
	
	public static inline var DPAD_UP:Int = 17;
	public static inline var DPAD_DOWN:Int = 18;
	public static inline var DPAD_LEFT:Int = 19;
	public static inline var DPAD_RIGHT:Int = 20;
	
#else		//"legacy"
	
	public static inline var SQUARE:Int = 0;
	public static inline var X:Int = 1;
	public static inline var CIRCLE:Int = 2;
	public static inline var TRIANGLE:Int = 3;
	public static inline var L1:Int = 4;
	public static inline var R1:Int = 5;
	
	public static inline var SHARE:Int = 8;
	public static inline var OPTIONS:Int = 9;
	public static inline var LEFT_STICK_CLICK:Int = 10;
	public static inline var RIGHT_STICK_CLICK:Int = 11;
	public static inline var PS:Int = 12;
	public static inline var TOUCHPAD_CLICK:Int = 13;
	
	//Axis ID's
	public static inline var L2:Int = 3;
	public static inline var R2:Int = 4;
	
	public static var LEFT_ANALOG_STICK(default, null) = new FlxGamepadAnalogStick(0, 1);
	public static var RIGHT_ANALOG_STICK(default, null) = new FlxGamepadAnalogStick(2, 5);
	
	//"fake" IDs, we manually watch for hat axis changes and then send events using these otherwise unused joystick button codes
	public static inline var DPAD_LEFT:Int = 15;
	public static inline var DPAD_RIGHT:Int = 16;
	public static inline var DPAD_DOWN:Int = 17;
	public static inline var DPAD_UP:Int = 18;
	
	//Analog stick and trigger values overlap with regular buttons so we remap to "fake" button ID's
	public static function axisIndexToRawID(index:Int):Int
	{
		return   if (index == LEFT_ANALOG_STICK.x) LEFT_ANALOG_STICK_FAKE_X;
			else if (index == LEFT_ANALOG_STICK.y) LEFT_ANALOG_STICK_FAKE_Y;
			else if (index == RIGHT_ANALOG_STICK.x) RIGHT_ANALOG_STICK_FAKE_X;
			else if (index == RIGHT_ANALOG_STICK.y) RIGHT_ANALOG_STICK_FAKE_Y;
			else if (index == L2) LEFT_TRIGGER_FAKE;
			else if (index == R2) RIGHT_TRIGGER_FAKE;
			else index;
	}
	
	//"fake" IDs
	public static inline var LEFT_ANALOG_STICK_FAKE_X:Int = 21;
	public static inline var LEFT_ANALOG_STICK_FAKE_Y:Int = 22;
	
	public static inline var RIGHT_ANALOG_STICK_FAKE_X:Int = 23;
	public static inline var RIGHT_ANALOG_STICK_FAKE_Y:Int = 24;
	
	public static inline var LEFT_TRIGGER_FAKE:Int = 25;
	public static inline var RIGHT_TRIGGER_FAKE:Int = 26;
#end
}
