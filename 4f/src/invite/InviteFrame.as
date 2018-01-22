package invite
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.data.player.BasePlayer;
   import ddt.data.player.FriendListPlayer;
   import ddt.data.player.PlayerInfo;
   import ddt.data.player.PlayerState;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.chat.ChatEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import invite.data.InvitePlayerInfo;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import room.RoomManager;
   import team.TeamManager;
   
   public class InviteFrame extends Frame
   {
      
      public static const RECENT:int = 0;
      
      public static const Brotherhood:int = 1;
      
      public static const Friend:int = 2;
      
      public static const Hall:int = 3;
      
      public static const TEAM:int = 4;
       
      
      private var _visible:Boolean = true;
      
      private var _resState:String;
      
      private var _listBack:MutipleImage;
      
      private var _refreshButton:TextButton;
      
      private var _fastInviteBtn:TextButton;
      
      private var _hbox:HBox;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _hallButton:SelectedTextButton;
      
      private var _frientButton:SelectedTextButton;
      
      private var _brotherhoodButton:SelectedTextButton;
      
      private var _recentContactBtn:SelectedTextButton;
      
      private var _teamButton:SelectedTextButton;
      
      private var _list:ListPanel;
      
      private var _changeComplete:Boolean = false;
      
      private var _refleshCount:int = 0;
      
      private var _invitePlayerInfos:Array;
      
      public var roomType:int;
      
      private var _titleSelectStatus:Object;
      
      private var _oldSelected:int;
      
      public function InviteFrame(){super();}
      
      private function configUi() : void{}
      
      private function addEvent() : void{}
      
      private function __freeInvitedHandler(param1:ChatEvent) : void{}
      
      protected function __onFastInviteClick(param1:MouseEvent) : void{}
      
      private function __confirmFastInvite(param1:FrameEvent) : void{}
      
      private function __btnChangeHandler(param1:Event) : void{}
      
      private function __response(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      private function __onRefreshClick(param1:MouseEvent) : void{}
      
      private function __onGetList(param1:PkgEvent) : void{}
      
      override protected function __onCloseClick(param1:MouseEvent) : void{}
      
      private function __itemClick(param1:ListItemEvent) : void{}
      
      private function sort(param1:Array) : Array{return null;}
      
      private function updateList(param1:int, param2:Array) : void{}
      
      private function clearList() : void{}
      
      private function getInsertIndex(param1:BasePlayer) : int{return 0;}
      
      private function __onResError(param1:UIModuleEvent) : void{}
      
      private function __onResComplete(param1:UIModuleEvent) : void{}
      
      private function refleshList(param1:int, param2:int = 0) : void{}
      
      private function get rerecentContactList() : Array{return null;}
      
      override public function dispose() : void{}
   }
}
