package wonderfulActivity.newActivity.GetRewardAct
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GmActivityInfo;
   import wonderfulActivity.data.SendGiftInfo;
   import wonderfulActivity.newActivity.AnnouncementAct.AnnouncementDetailView;
   import wonderfulActivity.views.IRightView;
   
   public class GetRewardActView extends Sprite implements IRightView
   {
       
      
      private var _actId:String;
      
      private var _back:DisplayObject;
      
      private var _titleField:FilterFrameText;
      
      private var _buttonBack:DisplayObject;
      
      private var _detailView:AnnouncementDetailView;
      
      private var _getButton:BaseButton;
      
      private var _scrollList:ScrollPanel;
      
      private var _content:VBox;
      
      private var _activityInfo:GmActivityInfo;
      
      private var _limitTime:Number = 0;
      
      public function GetRewardActView(param1:String){super();}
      
      public function init() : void{}
      
      private function addEvent() : void{}
      
      protected function __getRewardHandler(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      private function initView() : void{}
      
      private function initViewWithData() : void{}
      
      private function initData() : void{}
      
      public function setState(param1:int, param2:int) : void{}
      
      public function content() : Sprite{return null;}
      
      public function dispose() : void{}
   }
}
