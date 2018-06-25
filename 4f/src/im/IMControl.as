package im{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import consortion.ConsortionModelManager;   import ddt.data.player.ConsortiaPlayerInfo;   import ddt.data.player.FriendListPlayer;   import ddt.data.player.PlayerInfo;   import ddt.events.PkgEvent;   import ddt.manager.ChatManager;   import ddt.manager.IMManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.utils.Dictionary;   import road7th.comm.PackageIn;      public class IMControl extends EventDispatcher   {            private static var _instance:IMControl;                   private var _imview:IMView;            private var _currentPlayer:PlayerInfo;            private var _panels:Dictionary;            private var _isShow:Boolean;            private var _titleType:int;            private var _manager:IMManager;            public var customInfo:CustomInfo;            public var deleteCustomID:int;            private var _likeFriendList:Array;            public function IMControl() { super(); }
            public static function get Instance() : IMControl { return null; }
            public function setup() : void { }
            protected function __addCustomHandler(event:PkgEvent) : void { }
            public function checkHasNew(id:int) : Boolean { return false; }
            private function __addNewFriend(evt:IMEvent) : void { }
            private function privateChat() : void { }
            public function set isShow(value:Boolean) : void { }
            private function hide() : void { }
            private function show() : void { }
            protected function __onOpenView(event:IMEvent) : void { }
            private function __recentContactsComplete(event:Event) : void { }
            public function set titleType(value:int) : void { }
            public function get titleType() : int { return 0; }
            private function __imviewEvent(event:FrameEvent) : void { }
            public function getRecentContactsStranger() : Array { return null; }
            public function testAlikeName(name:String) : Boolean { return false; }
            public function set likeFriendList(value:Array) : void { }
            public function get likeFriendList() : Array { return null; }
   }}