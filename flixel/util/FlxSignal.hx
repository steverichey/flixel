package flixel.util;

import flixel.interfaces.IFlxDestroyable;
import flixel.interfaces.IFlxPooled;
import flixel.system.frontEnds.SignalFrontEnd;
import flixel.util.FlxPool;

/**
 * An object that contains a list of callbacks to be executed when dispatch is triggered.
 * 
 * @author Sam Batista (https://github.com/gamedevsam)
 */
class FlxSignal implements IFlxPooled
{
	private static var _pool = new FlxPool<FlxSignal>(FlxSignal);
	private static var _handlersPool = new FlxPool<SignalHandler>(SignalHandler);
	private static var _signals:Array<FlxSignal> = [];
	
	/**
	 * Creates a new signal or recycles a used one if available.
	 * 
	 * @param	Persist	If the signal should remain active between state switches.
	 */
	public static inline function get(Persist:Bool = false):FlxSignal
	{
		var signal = _pool.get();
		signal.persist = Persist;
		signal._inPool = false;
		_signals.push(signal);
		return signal;
	}
	
	@:allow(flixel.system.frontEnds.SignalFrontEnd)
	private static function onStateSwitch(_):Void
	{
		var i = _signals.length;
		while (i-- > 0)
		{
			if (!_signals[i].persist)
				_signals[i].put();
		}
	}
	
	/**
	 * If this signal is active and should dispatch events. IMPORTANT: Setting this 
	 * property during a  dispatch will only affect the next dispatch.
	 */
	public var active:Bool = true;
	/**
	 * If signal should remain active between state switches.
	 */
	public var persist:Bool = false;
	/**
	 * Object that contains data passed into the dispatch function (can be null).
	 */
	public var userData:Dynamic = null;
	
	private var _inPool:Bool = false;
	private var _handlers:Array<SignalHandler>;
	
	/**
	 * Restores this signal to the pool (destroys it in the process).
	 */
	public function put():Void
	{
		if (!_inPool)
		{
			_pool.putUnsafe(this);
			_inPool = true;
		}
	}
	
	/**
	 * Adds a function callback to be triggered when dispatch() is called. 
	 * Returns null if you try to add a null callback.
	 * 
	 * @return	This FlxSignal instance (nice for chaining stuff together, if you're into that).
	 */
	public function add(Callback:FlxSignal->Void, DispatchOnce:Bool = false):FlxSignal
	{
		if (Callback == null)
			return null;
			
		var handler:SignalHandler = _handlersPool.get().init(Callback, DispatchOnce);
		if (_handlers == null)
			_handlers = new Array<SignalHandler>();
		_handlers.push(handler);
		return this;
	}
	
	/**
	 * Determines whether the provided callback has been added to this signal.
	 * 
	 * @param	Callback	function callback to check
	 * @return	Bool	true if callback was found, otherwise false 
	 */
	public function has(Callback:FlxSignal->Void):Bool
	{
		if (Callback == null)
			return false;
		
		if (_handlers != null)
		{
			for (i in 0..._handlers.length)
			{
				if (_handlers[i]._callback == Callback)
					return true;
			}
		}
		return false;
	}
	
	/**
	 * Removes a callback.
	 */
	public function remove(Callback:FlxSignal->Void)
	{
		if (_handlers != null)
		{
			for (i in 0..._handlers.length)
			{
				if (_handlers[i]._callback == Callback)
				{
					FlxArrayUtil.swapAndPop(_handlers, i);
					return;
				}
			}
		}
	}
	
	/**
	 * Remove all callbacks from the Signal.
	 */
	public inline function removeAll()
	{
		FlxArrayUtil.clearArray(_handlers);
	}
	
	/**
	 * Dispatches this Signal to all bound callbacks.
	 * 
	 * @param	Data	Data temporaily stored in userData which can be accessed in callback functions.
	 */
	public function dispatch(?Data:Dynamic)
	{
		if (active && _handlers != null)
		{
			if (Data != null)
				userData = Data;
			
			var i = _handlers.length;
			
			// must count down when using swapAndPop
			while (i-- > 0)
			{
				var handler = _handlers[i];
				
				handler._callback(this);
				
				if (handler._isOnce)
					FlxArrayUtil.swapAndPop(_handlers, i);
			}
		}
	}
	
	public function destroy()
	{
		removeAll();
		_handlers = null;
		userData = null;
		FlxArrayUtil.fastSplice(_signals, this);
	}
}

private class SignalHandler implements IFlxDestroyable
{
	public var _isOnce:Bool;
	public var _callback:FlxSignal->Void;
	
	public function init(callback:FlxSignal->Void, isOnce:Bool)
	{
		_callback = callback;
		_isOnce = isOnce;
		return this;
	}
	
	public inline function destroy()
	{
		_callback = null;
	}
	
	private function new() {}
}