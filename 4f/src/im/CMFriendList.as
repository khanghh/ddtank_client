package im
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.CMFriendInfo;
   import ddt.data.player.FriendListPlayer;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   
   public class CMFriendList extends Sprite implements Disposeable
   {
      
      public static const LIST_MAX_NUM:int = 5;
       
      
      private var _list:VBox;
      
      private var _CMFriendArray:Array;
      
      private var _CMFriendItemArray:Array;
      
      private var _title:IMListItemView;
      
      private var _titleInfo:FriendListPlayer;
      
      private var _titleII:IMListItemView;
      
      private var _titleInfoII:FriendListPlayer;
      
      private var _currentTitleInfo:FriendListPlayer;
      
      private var _playCurrentPage:int;
      
      private var _playDDTListTotalPage:int;
      
      private var _unplayCurrentPage:int;
      
      private var _unplayDDTListTotalPage:int;
      
      private var _upPageBtn:BaseButton;
      
      private var _downPageBtn:BaseButton;
      
      private var _InviteBlogBtn:TextButton;
      
      private var _switchBtn1:SelectedCheckButton;
      
      private var _switchBtn2:SelectedCheckButton;
      
      private var _currentCMFInfo:CMFriendInfo;
      
      public function CMFriendList(){super();}
      
      private function init() : void{}
      
      private function initTitle() : void{}
      
      private function initEvent() : void{}
      
      private function __pageBtnClick(param1:MouseEvent) : void{}
      
      private function __inviteBolg(param1:MouseEvent) : void{}
      
      private function updatePageBtnState() : void{}
      
      private function __titleClick(param1:MouseEvent) : void{}
      
      private function updateList() : void{}
      
      private function updatePlayDDTList() : void{}
      
      private function updateUnPlayDDTList() : void{}
      
      private function creatItem() : void{}
      
      private function updateItem() : void{}
      
      private function updateListPos() : void{}
      
      private function cleanItem() : void{}
      
      private function __itemClick(param1:MouseEvent) : void{}
      
      private function __itemOut(param1:MouseEvent) : void{}
      
      private function __itemOver(param1:MouseEvent) : void{}
      
      private function resetItem() : void{}
      
      public function get currentCMFInfo() : CMFriendInfo{return null;}
      
      public function get currentTitleInfo() : FriendListPlayer{return null;}
      
      protected function __switchBtn1Click(param1:MouseEvent) : void{}
      
      protected function __switchBtn2Click(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
