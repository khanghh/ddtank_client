package ddt.view.chat
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.data.player.BasePlayer;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ChatFriendListPanel extends ChatBasePanel implements Disposeable
   {
      
      public static const FRIEND:uint = 0;
      
      public static const CONSORTIA:uint = 1;
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _btnConsortia:SelectedTextButton;
      
      private var _btnFriend:SelectedTextButton;
      
      private var _func:Function;
      
      private var _playerList:ListPanel;
      
      private var _showOffLineList:Boolean;
      
      private var _currentType:uint;
      
      public function ChatFriendListPanel(){super();}
      
      public function setup(param1:Function, param2:Boolean = true) : void{}
      
      public function set currentType(param1:int) : void{}
      
      private function updateBtns() : void{}
      
      public function refreshAllList() : void{}
      
      override public function set visible(param1:Boolean) : void{}
      
      override protected function __hideThis(param1:MouseEvent) : void{}
      
      private function __btnsClick(param1:MouseEvent) : void{}
      
      private function _scrollClick(param1:MouseEvent) : void{}
      
      private function __onFriendListComplete(param1:Event = null) : void{}
      
      private function __updateConsortiaList(param1:Event) : void{}
      
      private function __updateFriendList(param1:Event) : void{}
      
      override protected function init() : void{}
      
      override protected function initEvent() : void{}
      
      override protected function removeEvent() : void{}
      
      private function setList(param1:Array) : void{}
      
      private function __itemClick(param1:ListItemEvent) : void{}
      
      public function dispose() : void{}
   }
}
