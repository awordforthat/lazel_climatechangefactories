﻿package com.utils
{
	import flash.display.MovieClip;
	
	public class Utils
	{
		public static function StopAtFrameN(target:MovieClip, stopFrame:int = 0):void
		{
			if(!(target is MovieClip) || (stopFrame > target.totalFrames - 1) || (stopFrame < 0))
			{
				return;
			}
			
			target.gotoAndStop(stopFrame);
			
			if(target.numChildren == 0)
			{
				return;
			}

			for(var i:int = 0; i < target.totalFrames; i++)
			{
				for(var j:int = 0; j < target.numChildren; j++)
				{
					Utils.StopAtFrameN(target.getChildAt(j) as MovieClip);
				}
			}
		}
	}
}