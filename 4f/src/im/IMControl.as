package im
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import consortion.ConsortionModelManager;
   import ddt.data.player.ConsortiaPlayerInfo;
   import ddt.data.player.FriendListPlayer;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import road7th.comm.PackageIn;
   
   public class IMControl extends EventDispatcher
   {
      
      private static var _instance:IMControl;
       
      
      private var _imview:IMView;
      
      private var _currentPlayer:PlayerInfo;
      
      private var _panels:Dictionary;
      
      private var _isShow:Boolean;
      
      private var _titleType:int;
      
      private var _manager:IMManager;
      
      public var customInfo:CustomInfo;
      
      public var deleteCustomID:int;
      
      private var _likeFriendList:Array;
      
      public function IMControl(){super();}
      
      public static function get Instance() : IMControl{return null;}
      
      public function setup() : void{}
      
      protected function __addCustomHandler(param1:PkgEvent) : void{}
      
      public function checkHasNew(param1:int) : Boolean{return false;}
      
      private function __addNewFriend(param1:IMEvent) : void{}
      
      private function privateChat() : void{}
      
      public function set isShow(param1:Boolean) : void{}
      
      private function hide() : void{}
      
      private function show() : void{}
      
      protected function __onOpenView(param1:IMEvent) : void{}
      
      private function __recentContactsComplete(param1:Event) : void{}
      
      public function set titleType(param1:int) : void{}
      
      public function get titleType() : int{return 0;}
      
      private function __imviewEvent(param1:FrameEvent) : void{}
      
      public function getRecentContactsStranger() : Array{return null;}
      
      public function testAlikeName(param1:String) : Boolean{return false;}
      
      public function set likeFriendList(param1:Array) : void{}
      
      public function get likeFriendList() : Array{return null;}
   }
}
