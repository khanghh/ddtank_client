package wonderfulActivity.newActivity.AnnouncementAct
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GmActivityInfo;
   import wonderfulActivity.views.IRightView;
   
   public class AnnouncementActView extends Sprite implements IRightView
   {
       
      
      private var _actId:String;
      
      private var _back:DisplayObject;
      
      private var _titleField:FilterFrameText;
      
      private var _buttonBack:DisplayObject;
      
      private var _detailView:AnnouncementDetailView;
      
      private var _activityInfo:GmActivityInfo;
      
      private var _scrollList:ScrollPanel;
      
      private var _content:VBox;
      
      public function AnnouncementActView(id:String)
      {
         super();
         _actId = id;
      }
      
      public function init() : void
      {
         initView();
         initData();
         initViewWithData();
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
      
      public function setState(type:int, id:int) : void
      {
      }
      
      public function content() : Sprite
      {
         return this;
      }
      
      public function dispose() : void
      {
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
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
