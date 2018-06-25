package team.view.rank{   import com.pickgliss.ui.LayerManager;   import ddt.data.player.PlayerInfo;   import ddt.manager.ChatManager;   import ddt.manager.IMManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.view.character.CharactoryFactory;   import ddt.view.character.ShowCharacter;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.geom.Rectangle;   import flash.utils.ByteArray;   import team.TeamManager;   import team.model.TeamLevelInfo;   import team.model.TeamRankInfo;   import team.view.mornui.Rank.TeamRankRightViewUI;      public class TeamRankRightView extends TeamRankRightViewUI   {                   private var _figure:Bitmap;            private var _character:ShowCharacter;            private var _info:TeamRankInfo;            private var _enabled:Boolean;            public function TeamRankRightView() { super(); }
            override protected function initialize() : void { }
            private function show(info:PlayerInfo) : void { }
            protected function __characterComplete(event:Event) : void { }
            protected function __onClickAddFriend(event:MouseEvent) : void { }
            protected function __onClickChat(event:MouseEvent) : void { }
            private function getStrLen(_str:String) : String { return null; }
            private function headerNameProcess(_str:String) : String { return null; }
            public function updateInfo(info:TeamRankInfo) : void { }
            private function updaHead() : void { }
            public function set enabled(value:Boolean) : void { }
            private function deletehead() : void { }
            override public function dispose() : void { }
   }}