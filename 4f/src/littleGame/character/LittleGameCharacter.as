package littleGame.character{   import character.ComplexBitmapCharacter;   import character.action.ComplexBitmapAction;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.StringUtils;   import ddt.data.player.PlayerInfo;   import ddt.manager.PathManager;   import ddt.manager.SoundManager;   import flash.display.BitmapData;   import flash.events.Event;   import flash.net.URLLoader;   import flash.net.URLRequest;   import flash.utils.Dictionary;      public class LittleGameCharacter extends ComplexBitmapCharacter implements Disposeable   {            public static const WIDTH:Number = 230;            public static const HEIGHT:Number = 175;            public static var DEFINE:XML;                   private var _playerInfo:PlayerInfo;            private var _headBmd:BitmapData;            private var _bodyBmd:BitmapData;            private var headBmds:Vector.<BitmapData>;            private var _loader:LittleGameCharaterLoader;            private var hasFaceColor:Boolean = false;            private var hasClothColor:Boolean = false;            private var _isComplete:Boolean = false;            private var _currentAct:String;            private var _currentSoundPlayed:Boolean;            public function LittleGameCharacter(playerInfo:PlayerInfo, littleGameId:int = 1) { super(null,null,null,null,null); }
            public static function setup() : void { }
            public function get isComplete() : Boolean { return false; }
            public function set isComplete(value:Boolean) : void { }
            override public function doAction(action:String) : void { }
            override protected function set currentAction(action:ComplexBitmapAction) : void { }
            override protected function update() : void { }
            private function onComplete() : void { }
            override public function get actions() : Array { return null; }
            private function updateRenderSource(resource:String, renderData:BitmapData) : void { }
            public function setFunnyHead(type:uint = 0) : void { }
            override public function dispose() : void { }
   }}