package newYearRice.view{   import com.pickgliss.ui.core.Component;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.player.PlayerInfo;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.view.character.CharactoryFactory;   import ddt.view.character.ShowCharacter;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.Sprite;   import flash.events.Event;   import flash.geom.Point;   import flash.geom.Rectangle;   import flash.utils.Dictionary;   import newYearRice.NewYearRiceManager;      public class PlayerCell extends Sprite   {            public static const LEFT:String = "left";            public static const RIGHT:String = "right";                   private var _directrion:String;            private var _info:PlayerInfo;            private var _character:ShowCharacter;            private var _figure:Bitmap;            private var components:Component;            private var _dic:Dictionary;            private var _playerID:int;            private var _style:String;            private var _nikeName:String;            private var _sex:Boolean;            public function PlayerCell() { super(); }
            public function setNickName($playerID:int, $direction:String = "left", $style:String = "", $nikeName:String = "", $sex:Boolean = false) : void { }
            private function setInfo() : void { }
            private function __playerInfoChange(event:PlayerPropertyEvent) : void { }
            private function updateCharacter() : void { }
            private function __characterComplete(evt:Event) : void { }
            public function dispose() : void { }
            public function get playerID() : int { return 0; }
            public function get info() : PlayerInfo { return null; }
            public function removePlayerCell() : void { }
            public function set info(value:PlayerInfo) : void { }
            public function get nikeName() : String { return null; }
            public function set nikeName(value:String) : void { }
   }}