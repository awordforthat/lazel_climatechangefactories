package com.ui
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import com.events.Event_SliderRegionChange;

	public class SliderBar_Divided extends SliderBar
	{
		protected var m_NumDivisions:int
		protected var m_TriggerPoints:Array;
		protected var m_LastKnownRegion:int;
		
		public function SliderBar_Divided(handle:MovieClip, background:MovieClip, numDivisions:int, horizontal:Boolean = true,
		triggerAtZero:Boolean = false, triggerAtEnd:Boolean = false)
		{
			super(handle, background, horizontal);
			m_NumDivisions = numDivisions;
			m_LastKnownRegion = -1;
			this.populateTriggerPoints(triggerAtZero, triggerAtEnd);
		}
		
		private function populateTriggerPoints(triggerAtZero:Boolean, triggerAtEnd:Boolean):void
		{
			m_TriggerPoints = new Array();
			var segmentLength:Number = m_Background.width / m_NumDivisions;
			
			if(triggerAtZero) m_TriggerPoints.push(0);			
			
			for(var currentValue = segmentLength; currentValue < m_Background.width-1; currentValue += segmentLength)
			{
				m_TriggerPoints.push(currentValue);
			}
			trace(segmentLength);
			trace(m_Background.width);
			
			if(triggerAtEnd) m_TriggerPoints.push(m_Background.width);
			
			trace(m_TriggerPoints);
			
		}
		
		override protected function eh_MouseMove(e:MouseEvent)
		{
			super.eh_MouseMove(e);
			var distFromEdge = m_Handle.x - m_GlobalBackgroundLeftBound.x;
			var currentRegion = int(distFromEdge/(m_Background.width/m_NumDivisions));
			if(m_LastKnownRegion != currentRegion)
			{
				//dispatch region event
				this.dispatchEvent(new Event_SliderRegionChange(currentRegion, m_LastKnownRegion));
			}
			
			m_LastKnownRegion = currentRegion;
		}
		
	}
}