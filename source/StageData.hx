package;

import openfl.utils.Assets;
import haxe.Json;
import haxe.format.JsonParser;
import Song;

using StringTools;

typedef StageFile = {
	var directory:String;
	var defaultZoom:Float;
	var isPixelStage:Bool;

	var boyfriend:Array<Dynamic>;
	var girlfriend:Array<Dynamic>;
	var opponent:Array<Dynamic>;
}

class StageData {
	public static var forceNextDirectory:String = null;
	public static function loadDirectory(SONG:SwagSong) {
		var stage:String = '';
		if(SONG.stage != null) {
			stage = SONG.stage;
		} else if(SONG.song != null) {
			switch (SONG.song.toLowerCase().replace(' ', '-'))
			{
				case 'terminated':
					stage = 'larrybg';
				case 'vivisection':
					stage = 'doctorbg';
				case 'captivated':
					stage = 'captivated';
				case 'my-world'':
					stage = 'gocbg';
				case 'decaying':
					stage = 'gocbg';
				case 'me':
					stage = 'toiletbg';
				default:
					stage = 'stage';
			}
		} else {
			stage = 'stage';
		}

		var stageFile:StageFile = getStageFile(stage);
		if(stageFile == null) { //preventing crashes
			forceNextDirectory = '';
		} else {
			forceNextDirectory = stageFile.directory;
		}
	}

	public static function getStageFile(stage:String):StageFile {
		var rawJson:String = null;
		var path:String = Paths.getPreloadPath('stages/' + stage + '.json');

		if(Assets.exists(path)) {
			rawJson = Assets.getText(path);
		}
		else
		{
			return null;
		}
		return cast Json.parse(rawJson);
	}
}
				