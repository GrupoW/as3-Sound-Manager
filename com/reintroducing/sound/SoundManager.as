package com.reintroducing.sound
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import com.greensock.TweenLite;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.plugins.VolumePlugin;
	
		
	/**
	 * The SoundManager is a singleton that allows you to have various ways to control sounds in your project.
	 * <p />
	 * The SoundManager can load external or library sounds, pause/mute/stop/control volume for one or more sounds at a time, 
	 * fade sounds up or down, and allows additional control to sounds not readily available through the default classes.
	 * <p />
	 * This class is dependent on TweenLite (http://www.tweenlite.com) to aid in easily fading the volume of the sound.
	 * 
	 * @author Matt Przybylski [http://www.reintroducing.com]
	 * @version 1.0
	 */
	public class SoundManager
	{
//- PRIVATE & PROTECTED VARIABLES -------------------------------------------------------------------------

		// singleton instance
		private static var _instance:SoundManager;
		private static var _allowInstance:Boolean;
		
		private var _soundsDict:Dictionary;
		private var _sounds:Array;
		
//- PUBLIC & INTERNAL VARIABLES ---------------------------------------------------------------------------
		
		
		
//- CONSTRUCTOR	-------------------------------------------------------------------------------------------
	
		public static function getNewNull():SoundManager
		{
			SoundManager._allowInstance = true;
			var _instance:SoundManager = new NullSoundManager();
			SoundManager._allowInstance = false;				
			return _instance
		}

		// singleton instance of SoundManager
		public static function getInstance():SoundManager 
		{
			if (SoundManager._instance == null)
			{
				SoundManager._allowInstance = true;
				SoundManager._instance = new SoundManager();
				SoundManager._allowInstance = false;
			}
			
			return SoundManager._instance;
		}
		
		public function SoundManager() 
		{
			TweenPlugin.activate([VolumePlugin]);
			
			this._soundsDict = new Dictionary(true);
			this._sounds = new Array();
			
			if (!SoundManager._allowInstance)
			{
				throw new Error("Error: Use SoundManager.getInstance() instead of the new keyword.");
			}
		}
		
//- PRIVATE & PROTECTED METHODS ---------------------------------------------------------------------------
		
		
		
//- PUBLIC & INTERNAL METHODS -----------------------------------------------------------------------------
	
		/**
		 * Adds a sound from the library to the sounds dictionary for playing in the future.
		 * 
		 * @param $linkageID The class name of the library symbol that was exported for AS
		 * @param $name The string identifier of the sound to be used when calling other methods on the sound
		 * 
		 * @return Boolean A boolean value representing if the sound was added successfully
		 */
		public function addLibrarySound($linkageID:*, $name:String):Boolean
		{
			for (var i:int = 0; i < this._sounds.length; i++)
			{
				if (this._sounds[i].name == $name) return false;
			}
			
			var sndObj:Object = new Object();
			var snd:Sound = new $linkageID;
			
			sndObj.name = $name;
			sndObj.sound = snd;
			sndObj.channel = new SoundChannel();
			sndObj.position = 0;
			sndObj.paused = true;
			sndObj.volume = 1;
			sndObj.startTime = 0;
			sndObj.loops = 0;
			sndObj.pausedByAll = false;
			
			this._soundsDict[$name] = sndObj;
			this._sounds.push(sndObj);
			
			return true;
		}
			
		public function addSound($id:String):Boolean
		{
			return addLibrarySound(getDefinitionByName($id), $id);
		}
		
		public function addMultiplesSounds(value:Array):void
		{
			for each( var name_str:String in value) {
				addSound(name_str);
			}
		}
		
		/**
		 * Adds an external sound to the sounds dictionary for playing in the future.
		 * 
		 * @param $path A string representing the path where the sound is on the server
		 * @param $name The string identifier of the sound to be used when calling other methods on the sound
		 * @param $buffer The number, in milliseconds, to buffer the sound before you can play it (default: 1000)
		 * @param $checkPolicyFile A boolean that determines whether Flash Player should try to download a cross-domain policy file from the loaded sound's server before beginning to load the sound (default: false) 
		 * 
		 * @return Boolean A boolean value representing if the sound was added successfully
		 */
		public function addExternalSound($path:String, $name:String, $buffer:Number = 1000, $checkPolicyFile:Boolean = false):Boolean
		{
			for (var i:int = 0; i < this._sounds.length; i++)
			{
				if (this._sounds[i].name == $name) return false;
			}
			
			var sndObj:Object = new Object();
			var snd:Sound = new Sound(new URLRequest($path), new SoundLoaderContext($buffer, $checkPolicyFile));
			
			sndObj.name = $name;
			sndObj.sound = snd;
			sndObj.channel = new SoundChannel();
			sndObj.position = 0;
			sndObj.paused = true;
			sndObj.volume = 1;
			sndObj.startTime = 0;
			sndObj.loops = 0;
			sndObj.pausedByAll = false;
			
			this._soundsDict[$name] = sndObj;
			this._sounds.push(sndObj);
			
			return true;
		}
		
		/**
		 * Removes a sound from the sound dictionary.  After calling this, the sound will not be available until it is re-added.
		 * 
		 * @param $name The string identifier of the sound to remove
		 * 
		 * @return void
		 */
		public function removeSound($name:String):void
		{
			for (var i:int = 0; i < this._sounds.length; i++)
			{
				if (this._sounds[i].name == $name)
				{
					this._sounds[i] = null;
					this._sounds.splice(i, 1);
				}
			}
			
			delete this._soundsDict[$name];
		}
		
		/**
		 * Removes all sounds from the sound dictionary.
		 * 
		 * @return void
		 */
		public function removeAllSounds():void
		{
			for (var i:int = 0; i < this._sounds.length; i++)
			{
				this._sounds[i] = null;
			}
			
			this._sounds = new Array();
			this._soundsDict = new Dictionary(true);
		}

		/**
		 * Plays or resumes a sound from the sound dictionary with the specified name.
		 * 
		 * @param $name The string identifier of the sound to play
		 * @param $volume A number from 0 to 1 representing the volume at which to play the sound (default: 1)
		 * @param $startTime A number (in milliseconds) representing the time to start playing the sound at (default: 0)
		 * @param $loops An integer representing the number of times to loop the sound (default: 0)
		 * 
		 * @return void
		 */
		public function playSound($name:String, $volume:Number = 1, $startTime:Number = 0, $loops:int = 0):void
		{
			var snd:Object = this._soundsDict[$name];
			snd.volume = $volume;
			snd.startTime = $startTime;
			snd.loops = $loops;
				
			if (snd.paused)
			{
				snd.channel = snd.sound.play(snd.position, snd.loops, new SoundTransform(snd.volume));
			}
			else
			{
				snd.channel = snd.sound.play($startTime, snd.loops, new SoundTransform(snd.volume));
			}
			
			snd.paused = false;
		}
		
		/**
		 * Stops the specified sound.
		 * 
		 * @param $name The string identifier of the sound
		 * 
		 * @return void
		 */
		public function stopSound($name:String):void
		{
			var snd:Object = this._soundsDict[$name];
			snd.paused = true;
			snd.channel.stop();
			snd.position = snd.channel.position;
		}
		
		/**
		 * Pauses the specified sound.
		 * 
		 * @param $name The string identifier of the sound
		 * 
		 * @return void
		 */
		public function pauseSound($name:String):void
		{
			var snd:Object = this._soundsDict[$name];
			snd.paused = true;
			snd.position = snd.channel.position;
			snd.channel.stop();
		}
		
		/**
		 * Plays all the sounds that are in the sound dictionary.
		 * 
		 * @param $useCurrentlyPlayingOnly A boolean that only plays the sounds which were currently playing before a pauseAllSounds() or stopAllSounds() call (default: false)
		 * 
		 * @return void
		 */
		public function playAllSounds($useCurrentlyPlayingOnly:Boolean = false):void
		{
			for (var i:int = 0; i < this._sounds.length; i++)
			{
				var id:String = this._sounds[i].name;
				
				if ($useCurrentlyPlayingOnly)
				{
					if (this._soundsDict[id].pausedByAll)
					{
						this._soundsDict[id].pausedByAll = false;
						this.playSound(id);
					}
				}
				else
				{
					this.playSound(id);
				}
			}
		}
		
		/**
		 * Stops all the sounds that are in the sound dictionary.
		 * 
		 * @param $useCurrentlyPlayingOnly A boolean that only stops the sounds which are currently playing (default: true)
		 * 
		 * @return void
		 */
		public function stopAllSounds($useCurrentlyPlayingOnly:Boolean = true):void
		{
			for (var i:int = 0; i < this._sounds.length; i++)
			{
				var id:String = this._sounds[i].name;
				
				if ($useCurrentlyPlayingOnly)
				{
					if (!this._soundsDict[id].paused)
					{
						this._soundsDict[id].pausedByAll = true;
						this.stopSound(id);
					}
				}
				else
				{
					this.stopSound(id);
				}
			}
		}
		
		/**
		 * Pauses all the sounds that are in the sound dictionary.
		 * 
		 * @param $useCurrentlyPlayingOnly A boolean that only pauses the sounds which are currently playing (default: true)
		 * 
		 * @return void
		 */
		public function pauseAllSounds($useCurrentlyPlayingOnly:Boolean = true):void
		{
			for (var i:int = 0; i < this._sounds.length; i++)
			{
				var id:String = this._sounds[i].name;
				
				if ($useCurrentlyPlayingOnly)
				{
					if (!this._soundsDict[id].paused)
					{
						this._soundsDict[id].pausedByAll = true;
						this.pauseSound(id);
					}
				}
				else
				{
					this.pauseSound(id);
				}
			}
		}
		
		/**
		 * Fades the sound to the specified volume over the specified amount of time.
		 * 
		 * @param $name The string identifier of the sound
		 * @param $targVolume The target volume to fade to, between 0 and 1 (default: 0)
		 * @param $fadeLength The time to fade over, in seconds (default: 1)
		 * 
		 * @return void
		 */
		public function fadeSound($name:String, $targVolume:Number = 0, $fadeLength:Number = 1):void
		{
			var fadeChannel:SoundChannel = this._soundsDict[$name].channel;
			
			TweenLite.to(fadeChannel, $fadeLength, {volume: $targVolume});
		}
		
		/**
		 * Mutes the volume for all sounds in the sound dictionary.
		 * 
		 * @return void
		 */
		public function muteAllSounds():void
		{
			for (var i:int = 0; i < this._sounds.length; i++)
			{
				var id:String = this._sounds[i].name;
				
				this.setSoundVolume(id, 0);
			}
		}
		
		/**
		 * Resets the volume to their original setting for all sounds in the sound dictionary.
		 * 
		 * @return void
		 */
		public function unmuteAllSounds():void
		{
			for (var i:int = 0; i < this._sounds.length; i++)
			{
				var id:String = this._sounds[i].name;
				var snd:Object = this._soundsDict[id];
				var curTransform:SoundTransform = snd.channel.soundTransform;
				curTransform.volume = snd.volume;
				snd.channel.soundTransform = curTransform;
			}
		}
		
		/**
		 * Sets the volume of the specified sound.
		 * 
		 * @param $name The string identifier of the sound
		 * @param $volume The volume, between 0 and 1, to set the sound to
		 * 
		 * @return void
		 */
		public function setSoundVolume($name:String, $volume:Number):void
		{
			var snd:Object = this._soundsDict[$name];
			var curTransform:SoundTransform = snd.channel.soundTransform;
			curTransform.volume = $volume;
			snd.channel.soundTransform = curTransform;
		}
		
		/**
		 * Gets the volume of the specified sound.
		 * 
		 * @param $name The string identifier of the sound
		 * 
		 * @return Number The current volume of the sound
		 */
		public function getSoundVolume($name:String):Number
		{
			return this._soundsDict[$name].channel.soundTransform.volume;
		}
		
		/**
		 * Gets the position of the specified sound.
		 * 
		 * @param $name The string identifier of the sound
		 * 
		 * @return Number The current position of the sound, in milliseconds
		 */
		public function getSoundPosition($name:String):Number
		{
			return this._soundsDict[$name].channel.position;
		}
		
		/**
		 * Gets the duration of the specified sound.
		 * 
		 * @param $name The string identifier of the sound
		 * 
		 * @return Number The length of the sound, in milliseconds
		 */
		public function getSoundDuration($name:String):Number
		{
			return this._soundsDict[$name].sound.length;
		}
		
		/**
		 * Gets the sound object of the specified sound.
		 * 
		 * @param $name The string identifier of the sound
		 * 
		 * @return Sound The sound object
		 */
		public function getSoundObject($name:String):Sound
		{
			return this._soundsDict[$name].sound;
		}
		
		/**
		 * Identifies if the sound is paused or not.
		 * 
		 * @param $name The string identifier of the sound
		 * 
		 * @return Boolean The boolean value of paused or not paused
		 */
		public function isSoundPaused($name:String):Boolean
		{
			return this._soundsDict[$name].paused;
		}
		
		/**
		 * Identifies if the sound was paused or stopped by calling the stopAllSounds() or pauseAllSounds() methods.
		 * 
		 * @param $name The string identifier of the sound
		 * 
		 * @return Number The boolean value of pausedByAll or not pausedByAll
		 */
		public function isSoundPausedByAll($name:String):Boolean
		{
			return this._soundsDict[$name].pausedByAll;
		}

//- EVENT HANDLERS ----------------------------------------------------------------------------------------
	
		

//- GETTERS & SETTERS -------------------------------------------------------------------------------------
	
		public function get sounds():Array
		{
		    return this._sounds;
		}
	
//- HELPERS -----------------------------------------------------------------------------------------------
	
		public function toString():String
		{
			return getQualifiedClassName(this);
		}
	
//- END CLASS ---------------------------------------------------------------------------------------------
	}
}