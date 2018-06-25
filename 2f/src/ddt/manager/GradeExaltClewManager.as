package ddt.manager{   import com.pickgliss.manager.CacheSysManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.Experience;   import ddt.data.player.PlayerInfo;   import ddt.events.DuowanInterfaceEvent;   import ddt.events.PlayerPropertyEvent;   import ddt.utils.PositionUtils;   import ddt.view.character.CharactoryFactory;   import ddt.view.character.RoomCharacter;   import ddt.view.chat.ChatData;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;      public class GradeExaltClewManager   {            public static const LIGHT:int = 1;            public static const BLACK:int = 2;            private static var instance:GradeExaltClewManager;                   private var _asset:MovieClip;            private var _increBlood:String;            private var _grade:int;            private var _character:RoomCharacter;            private var _isSteup:Boolean = false;            private var _info:PlayerInfo;            private var _bloodMovie:Sprite;            public function GradeExaltClewManager() { super(); }
            public static function getInstance() : GradeExaltClewManager { return null; }
            public function setup() : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            private function __GradeExalt(e:PlayerPropertyEvent) : void { }
            public function show(type:int) : void { }
            private function creatNumberMovie() : Sprite { return null; }
            private function end() : void { }
            private function __cartoonFrameHandler(event:Event) : void { }
            public function hide() : void { }
   }}