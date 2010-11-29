package com.reintroducing.sound
{
	import flash.media.Sound;
	import flash.utils.getQualifiedClassName;
		

	public class NullSoundManager extends SoundManager
	{	
		
		public function NullSoundManager() 
		{
			
		}
		
		override public function addLibrarySound($linkageID:*, $name:String):Boolean
		{
			return true;
		}
		
		override public function addExternalSound($path:String, $name:String, $buffer:Number = 1000, $checkPolicyFile:Boolean = false):Boolean
		{
			return true;
		}
		

		override public function removeSound($name:String):void
		{
			
		}
		
		override public function removeAllSounds():void
		{
			
		}

	
		override public function playSound($name:String, $volume:Number = 1, $startTime:Number = 0, $loops:int = 0):void
		{
			
		}
		
	
		override public function stopSound($name:String):void
		{
			
		}
		
	
		override public function pauseSound($name:String):void
		{
			
		}
		
		
		override public function playAllSounds($useCurrentlyPlayingOnly:Boolean = false):void
		{
			
		}
		
		override public function stopAllSounds($useCurrentlyPlayingOnly:Boolean = true):void
		{
			
		}
		
		override public function pauseAllSounds($useCurrentlyPlayingOnly:Boolean = true):void
		{
			
		}
		
		override public function fadeSound($name:String, $targVolume:Number = 0, $fadeLength:Number = 1):void
		{
			
		}
		
		
		override public function muteAllSounds():void
		{
			
		}
		
		
		override public function unmuteAllSounds():void
		{
			
		}
		
		override public function setSoundVolume($name:String, $volume:Number):void
		{
			
		}
		
		override public function getSoundVolume($name:String):Number
		{
			return 0;
		}
		
		
		override public function getSoundPosition($name:String):Number
		{
			return 0;
		}
		
		
		override public function getSoundDuration($name:String):Number
		{
			return 0;
		}
		
		
		override public function getSoundObject($name:String):Sound
		{
			return new Sound();
		}
		
		
		override public function isSoundPaused($name:String):Boolean
		{
			return true;
		}
		
		override public function isSoundPausedByAll($name:String):Boolean
		{
			return true;
		}
	
		override public function get sounds():Array
		{
		    return new Array();
		}
	
		override public function toString():String
		{
			return getQualifiedClassName(this);
		}
	
	}
}