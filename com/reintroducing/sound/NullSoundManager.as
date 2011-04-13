package com.reintroducing.sound
{
	import flash.media.Sound;
	import flash.utils.getQualifiedClassName;
	
	public class NullSoundManager extends SoundManager
	{

		public function NullSoundManager() 
		{
			
		}
		
		override public static function getInstance():SoundManager 
		{
			return new NullSoundManager();
		}

		override public function addSound($linkageID:String):Boolean
		{
			return true;
		}

		override public function addMultiplesSounds($collection:Array):void
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
		
		override public function addPreloadedSound($sound:Sound, $name:String):Boolean
		{
			return true;
		}
		
		override public function removeSound($name:String):void
		{
		
		}
		
		override public function removeAllSounds():void
		{
		
		}

		override public function playSound($name:String, $volume:Number = 1, $startTime:Number = 0, $loops:int = 0, $resumeTween:Boolean = true):void
		{
			
		}
		
		override public function pauseSound($name:String, $pauseTween:Boolean = true):void
		{
			
		}
		
		override public function stopSound($name:String):void
		{
		
		}
		
		override public function playAllSounds($resumeTweens:Boolean = true, $useCurrentlyPlayingOnly:Boolean = false):void
		{
			
		}
		
		override public function pauseAllSounds($pauseTweens:Boolean = true, $useCurrentlyPlayingOnly:Boolean = true):void
		{
		
		}
		
		override public function stopAllSounds($useCurrentlyPlayingOnly:Boolean = true):void
		{
			
		}
		
		override public function fadeSound($name:String, $targVolume:Number = 0, $fadeLength:Number = 1, $stopOnComplete:Boolean = false):void
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
		
		override public function getSoundItem($name:String):SoundItem
		{
			return new SoundItem();
		}
		
		override public function isSoundPaused($name:String):Boolean
		{
			return false;
		}
		
		override public function isSoundPausedByAll($name:String):Boolean
		{
			return false;
		}
	
		override public function get sounds():Array
		{
		    return new Array();
		}
		
		override public function get areAllMuted():Boolean
		{
		    return false;
		}
		
		override override public function toString():String
		{
			return getQualifiedClassName(this);
		}
	}
}