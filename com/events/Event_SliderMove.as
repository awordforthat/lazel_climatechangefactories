package com.events
{
	import flash.events.Event;

	public class Event_SliderMove extends Event
	{
		public static const SLIDER_MOVED:String = "com.events.Event_SliderMove";
		private var m_PercentAlongLength:Number;
		
		public function Event_SliderMove(percentDistance:Number)
		{
			super(Event_SliderMove.SLIDER_MOVED);
			m_PercentAlongLength = percentDistance;
		}
		
		public function get percentDistance():Number
		{
			return m_PercentAlongLength;
		}
	}
}