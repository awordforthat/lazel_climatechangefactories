package com.events
{
	import flash.events.Event;

	public class Event_SliderRegionChange extends Event
	{
		public static const REGION_CHANGED:String = "com.events.Event_SliderRegionChange";
		private var m_CurrentRegion:int;
		private var m_LastRegion:int;
		
		public function Event_SliderRegionChange(currentRegion:int, lastRegion:int)
		{
			super(Event_SliderRegionChange.REGION_CHANGED);
			m_CurrentRegion = currentRegion;
			m_LastRegion = lastRegion;
		}
		
		public function get currentRegion():int
		{
			return m_CurrentRegion;
		}
		
		public function get lastRegion():int
		{
			return m_LastRegion;
		}
	}
}