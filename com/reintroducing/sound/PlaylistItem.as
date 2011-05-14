package com.reintroducing.sound
{
	public class PlaylistItem
	{
		private var _name:String;
		// Holds all the sound names which are part of this playlist.
		private var _soundsList:Array;
		// Holds the currently unplayed sounds which are part of this playlist. 
		private var _availableSoundsList:Array;
		
		public function PlaylistItem( $name:String )
		{
			_name = $name;
			_soundsList = new Array();
			_availableSoundsList = new Array();
		}

		public function get name():String
		{
			return _name;
		}
		
		/**
		 * Adds a sound to this playlist. 
		 * 
		 * @param $soundName The string representation of the sound you want to add to this playlist
		 * @param $multiple If you want to have this sound added to the playlist more then once. 
		 */
		internal function addSound( $soundName:String, $multiple:Boolean = false ):void
		{
			if( $multiple == false && _soundsList.indexOf( $soundName ) != -1 )
			{
				trace( new Error( "Adding sound [" + $soundName + "] to playlist [" + name + "] more then once.").getStackTrace() );
				return;
			}
			
			_soundsList.push( $soundName );
			_availableSoundsList.push( $soundName );
			
		}
		
		
		/**
		 * Adds a sound to this playlist. 
		 * 
		 * @param $soundName The string representation of the sound you want to remove to this playlist
		 * @param $all If you want to remove all instances of this sound. If false, remove only the first instance.
		 */
		internal function removeSound( $soundName:String, $all:Boolean = true ):void
		{
			if( _soundsList.indexOf( $soundName ) != -1 )
			{
				trace( new Error( "Sound [" + $soundName + "] does not exist in playlist [" + name + "].").getStackTrace() );
				return;
			}
			
			var index:int = _soundsList.indexOf( $soundName );
			while( index != -1 )
			{
				_soundsList.splice( index, 1 );
				index = _availableSoundsList.indexOf( $soundName );
				_availableSoundsList.splice( index, 1 );
				if( $all == false ) break;
				index = _soundsList.indexOf( $soundName );
			}

		}
		
		/**
		 * Clears the playlist of all sounds. 
		 */
		internal function clear():void
		{
			_soundsList = new Array();
			_availableSoundsList = new Array();
		}
		
		internal function getSound( $random:Boolean = false ):String
		{
			if( _soundsList.length == 0 ) return "";
			
			var sound:String;
			var index:int;
			
			if( $random )
			{
				index = Math.random() * _availableSoundsList.length;
				
				sound = _availableSoundsList.splice( Math.floor( index ), 1)[0];
			}
			else
			{
				sound = _availableSoundsList.shift();
			}
			
			// if no sounds left...
			if( _availableSoundsList.length == 0 )
			{
				_availableSoundsList = _soundsList.concat();
			}
			
			return sound;
		}

	}
}