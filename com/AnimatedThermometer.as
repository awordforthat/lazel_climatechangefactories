package com
{
	import flash.display.MovieClip;
	import flash.events.Event;

	// this class is specific to the ClimateChange_Factories interactive, because the internal structure of the thermometer is unique
	public class AnimatedThermometer extends MovieClip
	{
		private var m_Source:MovieClip;
		private var m_MercuryHeights:Vector.<Number>;
		private var m_Mercury:MovieClip;
		private var m_TargetHeight:Number;
		private var m_StepValue:Number;
		
		public function AnimatedThermometer(srcClip:MovieClip)
		{
			m_Source = srcClip;
			m_MercuryHeights = new Vector.<Number>();
			this.initialize();
		}
		
		private function initialize():void
		{
			// populate mercury heights
			// seed the array with a dummy value in the 0th position so it lines up with the
			// states of the main timeline animation
			
			
			for(var j:int = 0; j < m_Source.numChildren; j++)
			{

				if(m_Source.getChildAt(j).name.indexOf("mercuryReference") != -1)
				{
					m_MercuryHeights.push(m_Source.getChildAt(j).y);
					m_Source.getChildAt(j).visible = false;
				}
			}
			
			// identify mercury slider
			m_Mercury = m_Source.getChildByName("mcMercury") as MovieClip;
			m_MercuryHeights = m_MercuryHeights.sort(Array.DESCENDING); // Descending because we want to move physically upwards as we progress
			// duplicate the highest numerical / lowest physical value because states 0 and 1 are identical
			m_MercuryHeights.push(m_MercuryHeights[0]);
			m_MercuryHeights.sort(Array.DESCENDING);

			Reset();
			
		}
		
		private function eh_HandleSliderAnimation(e:Event):void
		{
			
			if((m_Mercury.y <= m_TargetHeight + 1) && (m_Mercury.y >= m_TargetHeight - 1))
			{
				this.removeEventListener(Event.ENTER_FRAME, this.eh_HandleSliderAnimation);
			}
			
			m_Mercury.y -= m_StepValue;
		}
		
		public function AnimateToPosition(index:int):void
		{
			this.addEventListener(Event.ENTER_FRAME, this.eh_HandleSliderAnimation, false, 0, true);

			m_TargetHeight = m_MercuryHeights[index];
			m_StepValue = Math.abs(m_Mercury.y - m_TargetHeight) / Document.SECTION_ANIMATION_LENGTH; // distance to move / number of total animation frames
		}
		
		public function Reset()
		{
			m_TargetHeight = m_MercuryHeights[0]; 
			m_Mercury.y = m_TargetHeight;
			
		}
		
		
	}
}