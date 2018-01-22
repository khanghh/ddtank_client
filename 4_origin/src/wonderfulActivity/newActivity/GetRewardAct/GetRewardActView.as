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
      
      public function GetRewardActView(param1:String)
      {
         super();
         _actId = param1;
      }
      
      public function init() : void
      {
         initView();
         addEvent();
         initData();
         initViewWithData();
      }
      
      private function addEvent() : void
      {
         _getButton.addEventListener("click",__getRewardHandler);
      }
      
      protected function __getRewardHandler(param1:MouseEvent) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:* = null;
         var _loc3_:* = null;
         SoundManager.instance.playButtonSound();
         if(getTimer() - _limitTime > 1500)
         {
            _limitTime = getTimer();
            _loc4_ = new Vector.<SendGiftInfo>();
            _loc2_ = new SendGiftInfo();
            _loc2_.activityId = _activityInfo.activityId;
            _loc3_ = [];
            _loc3_.push(_activityInfo.giftbagArray[0].giftbagId);
            _loc2_.giftIdArr = _loc3_;
            _loc4_.push(_loc2_);
            SocketManager.Instance.out.sendWonderfulActivityGetReward(_loc4_);
         }
      }
      
      private function removeEvent() : void
      {
         _getButton.removeEventListener("click",__getRewardHandler);
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityStateBg");
         addChild(_back);
         PositionUtils.setPos(_back,"wonderful.getRewardView.backPos");
         _titleField = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityStateTitleField");
         addChild(_titleField);
         PositionUtils.setPos(_titleField,"wonderful.getRewardView.titlePos");
         _buttonBack = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityState.GetButtonBackBg");
         addChild(_buttonBack);
         PositionUtils.setPos(_buttonBack,"wonderful.getRewardView.buttonBackPos");
         _detailView = new AnnouncementDetailView();
         _content = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityState.Vbox");
         _content.addChild(_detailView);
         _scrollList = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityDetailList");
         _scrollList.setView(_content);
         addChild(_scrollList);
         PositionUtils.setPos(_scrollList,"wonderful.getRewardView.detailViewPos");
         _getButton = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityState.GetButton");
         addChild(_getButton);
         PositionUtils.setPos(_getButton,"wonderful.getRewardView.getButtonPos");
      }
      
      private function initViewWithData() : void
      {
         if(!_activityInfo)
         {
            return;
         }
         _titleField.text = _activityInfo.activityName;
         _detailView.setData(_activityInfo);
         _content.arrange();
         _scrollList.invalidateViewport();
      }
      
      private function initData() : void
      {
         _activityInfo = WonderfulActivityManager.Instance.activityData[_actId];
      }
      
      public function setState(param1:int, param2:int) : void
      {
      }
      
      public function content() : Sprite
      {
         return this;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
         }
         _back = null;
         if(_titleField)
         {
            ObjectUtils.disposeObject(_titleField);
         }
         _titleField = null;
         if(_buttonBack)
         {
            ObjectUtils.disposeObject(_buttonBack);
         }
         _buttonBack = null;
         if(_detailView)
         {
            ObjectUtils.disposeObject(_detailView);
         }
         _detailView = null;
         if(_scrollList)
         {
            ObjectUtils.disposeObject(_scrollList);
         }
         _scrollList = null;
         if(_content)
         {
            ObjectUtils.disposeObject(_content);
         }
         _content = null;
         if(_getButton)
         {
            ObjectUtils.disposeObject(_getButton);
         }
         _getButton = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
