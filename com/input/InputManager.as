package com.input
{
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	
	public class InputManager
	{
		private static var m_isTouchEnabled:Boolean;
		private static var m_isUsingTouchEvents:Boolean;
		
		// all the different mouse/touch events
		private static var m_Click:String; // mouse click or touch_tap
		private static var m_Down:String; // mouse down or touch_begin
		private static var m_Up:String; // mouse up or touch_end
		private static var m_Out:String; // mouse out or touch_out
		private static var m_Move:String; // mouse move or touch_move
		private static var m_Over:String; // mouse over or touch_over
		
		public static function Init(enableTouchCapability:Boolean):void
		{
			m_Click = enableTouchCapability ? TouchEvent.TOUCH_TAP : MouseEvent.CLICK;
			m_Down = enableTouchCapability ? TouchEvent.TOUCH_BEGIN : MouseEvent.MOUSE_DOWN;
			m_Up = enableTouchCapability ? TouchEvent.TOUCH_END : MouseEvent.MOUSE_UP;
			m_Out = enableTouchCapability ? TouchEvent.TOUCH_OUT : MouseEvent.MOUSE_OUT;
			m_Move = enableTouchCapability ? TouchEvent.TOUCH_MOVE : MouseEvent.MOUSE_MOVE;
			m_Over = enableTouchCapability ? TouchEvent.TOUCH_OVER : MouseEvent.MOUSE_OVER;
		}
		
		
		public static function Click():String
		{
			return m_Click;
		}
		
		public static function Down():String
		{
			return m_Down;
		}
		
		public static function Up():String
		{
			return m_Up;
		}
		
		public static function Out():String
		{
			return m_Out;
		}
		
		public static function Move():String
		{
			return m_Move;
		}
		
		public static function Over():String
		{
			return m_Over;
		}
	}
}