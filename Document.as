package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.utils.Utils;
	import flash.events.MouseEvent;
	
	
	public class Document extends MovieClip {
		
		private var m_CurrentState:int;
		private const SECTION_ANIMATION_LENGTH:int = 30;
		private const NUM_STATES:int = 6; // six because we're starting from 0 and go to 5
		
		public function Document() {
			this.addEventListener(Event.ADDED_TO_STAGE, this.init);
			
		}
		
		private function init(e:Event)
		{
			Utils.StopAtFrameN(mcInteractivePanel);
			this.resetState();
			this.enablePlusButton();
			this.enableResetButton();
		}
		
		private function eh_HandlePlusClick(e:MouseEvent):void
		{
			// this starts the animation listener that reports when to stop
			this.addEventListener(Event.ENTER_FRAME, this.eh_HandleAnimationControl, false, 0, true);
			
			var animationFrame = m_CurrentState * SECTION_ANIMATION_LENGTH;
			mcInteractivePanel.gotoAndPlay(animationFrame);
			
			m_CurrentState++;  //  no need to % this because the reset button takes care of it

			// if there are no more states after this one, turn the + button completely gray
			if(m_CurrentState == NUM_STATES)
			{
				this.disablePlusButton(true);
			}
			else
			{
				this.disablePlusButton(false);
			}
		}
		
		private function eh_HandleAnimationControl(e:Event)
		{
			if(mcInteractivePanel.currentFrame % SECTION_ANIMATION_LENGTH == 0)
			{
				mcInteractivePanel.stop();
				
				// only reenable the + button if we're not at the end of the animation
				if(m_CurrentState != NUM_STATES)
				{
					this.enablePlusButton();
				}
				
				// stop listening every frame once we've stopped the animation. Readded in + button handler
				this.removeEventListener(Event.ENTER_FRAME, this.eh_HandleAnimationControl);
			}
		}
		
		private function disablePlusButton(disableCompletely:Boolean)
		{
			mcInteractivePanel.mcButtonPlus.removeEventListener(MouseEvent.CLICK, this.eh_HandlePlusClick);
			
			if(disableCompletely)
			{
				mcInteractivePanel.mcButtonPlus.gotoAndStop(3); // this is completely grayed out
			}
			else
			{
				mcInteractivePanel.mcButtonPlus.gotoAndStop(2); // this is the desaturated purple state
			}
			
		}
		
		private function enablePlusButton()
		{
			
			if(!mcInteractivePanel.mcButtonPlus.hasEventListener(MouseEvent.CLICK))
			{
				mcInteractivePanel.mcButtonPlus.addEventListener(MouseEvent.CLICK, this.eh_HandlePlusClick, false, 0, true);
			}
			
			mcInteractivePanel.mcButtonPlus.gotoAndStop(1);
		}
		
		private function eh_HandleResetClick(e:MouseEvent)
		{
			mcInteractivePanel.gotoAndStop(0);
			this.enablePlusButton();
			this.resetState();
		}
		
		private function enableResetButton()
		{
			mcInteractivePanel.mcButtonReset.addEventListener(MouseEvent.CLICK, this.eh_HandleResetClick, false, 0, true);
		}
		
		private function disableResetButton()
		{
			mcInteractivePanel.mcButtonReset.addEventListener(MouseEvent.CLICK, this.eh_HandleResetClick);
		}
		
		private function resetState()
		{
			m_CurrentState = 1;
		}
		
		
	}
	
}
