package dayActivity
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dayActivity.view.DayActiveView;
   import dayActivity.view.DayActivityAdvView;
   import dayActivity.view.DayActivityView;
   import dayActivity.view.OnlineRewardView;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import times.TimesManager;
   
   public class ActivityFrame extends Frame implements Disposeable
   {
       
      
      private var _dayActivityBtn:SelectedButton;
      
      private var _dayActiveBtn:SelectedButton;
      
      private var _dayActivityAdvBtn:SelectedButton;
      
      private var _onLineRewardBtn:SelectedButton;
      
      private var _seleBtnGroup:SelectedButtonGroup;
      
      private var _treeImage:ScaleBitmapImage;
      
      private var _dayActivityView:DayActivityView;
      
      private var _dayActiveView:DayActiveView;
      
      private var _dayActivityAdvView:DayActivityAdvView;
      
      private var _onlineRewardView:OnlineRewardView;
      
      private var _serverTimeTxt:FilterFrameText;
      
      private var _serverTimeTxtStr:String;
      
      private var _serverTimer:Timer;
      
      public function ActivityFrame()
      {
         super();
         escEnable = true;
         initView();
         addEvent();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",_response);
         _seleBtnGroup.addEventListener("change",changeHandler);
      }
      
      public function updataBtn(param1:int) : void
      {
         _dayActivityView.updataBtn(param1);
      }
      
      protected function changeHandler(param1:Event) : void
      {
         showView(_seleBtnGroup.selectIndex);
      }
      
      private function showView(param1:int) : void
      {
         hideAll();
         SoundManager.instance.play("008");
         var _loc2_:ISelectable = _seleBtnGroup.getItemByIndex(param1);
         if(_loc2_ == _dayActivityBtn)
         {
            if(_dayActiveView)
            {
               _dayActiveView.visible = true;
               _dayActiveView.updata(DayActivityManager.Instance.sessionArr);
            }
            else
            {
               _dayActiveView = new DayActiveView(DayActivityManager.Instance.acitiveDataList);
               _dayActiveView.y = 5;
               _dayActiveView.updata(DayActivityManager.Instance.sessionArr);
               addToContent(_dayActiveView);
            }
         }
         else if(_loc2_ == _dayActiveBtn)
         {
            if(_dayActivityView)
            {
               _dayActivityView.visible = true;
               _dayActivityView.setLeftView(DayActivityManager.Instance.overList,DayActivityManager.Instance.noOverList);
               _dayActivityView.setBar(DayActivityManager.Instance.activityValue);
            }
            else
            {
               _dayActivityView = new DayActivityView();
               _dayActivityView.setLeftView(DayActivityManager.Instance.overList,DayActivityManager.Instance.noOverList);
               _dayActivityView.setBar(DayActivityManager.Instance.activityValue);
               addToContent(_dayActivityView);
            }
         }
         else if(_loc2_ == _dayActivityAdvBtn)
         {
            if(_dayActivityAdvView)
            {
               _dayActivityAdvView.visible = true;
            }
            else
            {
               _dayActivityAdvView = new DayActivityAdvView(TimesManager.Instance.updateContentList);
               addToContent(_dayActivityAdvView);
               PositionUtils.setPos(_dayActivityAdvView,"activityAdv.viewPos");
            }
         }
         else if(_loc2_ == _onLineRewardBtn)
         {
            if(!_onlineRewardView)
            {
               _onlineRewardView = new OnlineRewardView();
            }
            _onlineRewardView.visible = true;
            addToContent(_onlineRewardView);
            PositionUtils.setPos(_onlineRewardView,"day.activity.onlineReward.viewPos");
         }
      }
      
      public function setLeftView(param1:Vector.<ActivityData>, param2:Vector.<ActivityData>) : void
      {
         _dayActivityView.setLeftView(param1,param2);
      }
      
      public function setBar(param1:int) : void
      {
         _dayActivityView.setBar(param1);
      }
      
      public function updata(param1:Array) : void
      {
         _dayActiveView.updata(param1);
      }
      
      private function initActivityFrame() : void
      {
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleSmallLoading.Instance.addEventListener("close",onSmallLoadingClose);
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",createActivityFrame);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUIProgress);
         UIModuleLoader.Instance.addUIModuleImp("ddtcalendar");
      }
      
      protected function onUIProgress(param1:UIModuleEvent) : void
      {
         if(param1.module == "ddtcalendar")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      protected function createActivityFrame(param1:UIModuleEvent) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",onSmallLoadingClose);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",createActivityFrame);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",onUIProgress);
      }
      
      protected function onSmallLoadingClose(param1:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",onSmallLoadingClose);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",createActivityFrame);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",onUIProgress);
      }
      
      private function hideAll() : void
      {
         if(_dayActiveView)
         {
            _dayActiveView.visible = false;
         }
         if(_dayActivityView)
         {
            _dayActivityView.visible = false;
         }
         if(_dayActivityAdvView)
         {
            _dayActivityAdvView.visible = false;
         }
         if(_onlineRewardView)
         {
            _onlineRewardView.visible = false;
         }
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("ddt.dayActivity.title");
         _treeImage = ComponentFactory.Instance.creatComponentByStylename("dayActivity.scale9cornerImageTree");
         addToContent(_treeImage);
         _dayActivityBtn = ComponentFactory.Instance.creatComponentByStylename("dayActivity.ActivityFrame.seleBtn1");
         addToContent(_dayActivityBtn);
         _dayActiveBtn = ComponentFactory.Instance.creatComponentByStylename("dayActivity.ActivityFrame.seleBtn2");
         addToContent(_dayActiveBtn);
         if(TimesManager.Instance.isShowActivityAdvView)
         {
            _dayActivityAdvBtn = ComponentFactory.Instance.creatComponentByStylename("dayActivity.ActivityFrame.seleBtn3");
            addToContent(_dayActivityAdvBtn);
         }
         _seleBtnGroup = new SelectedButtonGroup();
         _seleBtnGroup.addSelectItem(_dayActivityBtn);
         _seleBtnGroup.addSelectItem(_dayActiveBtn);
         if(TimesManager.Instance.isShowActivityAdvView)
         {
            _seleBtnGroup.addSelectItem(_dayActivityAdvBtn);
         }
         var _loc1_:int = 1;
         if(DayActivityManager.Instance.isOnLineRewardOpen())
         {
            _onLineRewardBtn = UICreatShortcut.creatAndAdd("day.activity.onlineReward.tabBtn",_container);
            if(TimesManager.Instance.isShowActivityAdvView)
            {
               PositionUtils.setPos(_onLineRewardBtn,"day.activity.onlineReward.tabBtn2");
            }
            else
            {
               PositionUtils.setPos(_onLineRewardBtn,"day.activity.onlineReward.tabBtn1");
            }
            _seleBtnGroup.addSelectItem(_onLineRewardBtn);
            if(DayActivityManager.Instance.canGetOnlineReward())
            {
               _loc1_ = _seleBtnGroup.getSelectIndexByItem(_onLineRewardBtn);
            }
         }
         _seleBtnGroup.selectIndex = _loc1_;
         showView(_seleBtnGroup.selectIndex);
         _serverTimeTxt = ComponentFactory.Instance.creatComponentByStylename("day.activieView.serverTimeTxt");
         _serverTimeTxtStr = LanguageMgr.GetTranslation("ddt.activieView.serverTimeTxtTitle");
         updateServerTime();
         addToContent(_serverTimeTxt);
         _serverTimer = new Timer(10000);
         _serverTimer.addEventListener("timer",updateServerTime);
         _serverTimer.start();
      }
      
      private function updateServerTime(param1:TimerEvent = null) : void
      {
         var _loc2_:* = null;
         if(_serverTimeTxt)
         {
            _loc2_ = TimeManager.Instance.Now();
            _serverTimeTxt.text = _serverTimeTxtStr + (_loc2_.date < 10?"0" + _loc2_.date:_loc2_.date) + "/" + (_loc2_.month + 1) + " " + (_loc2_.hours < 10?"0" + _loc2_.hours:_loc2_.hours) + ":" + (_loc2_.minutes < 10?"0" + _loc2_.minutes:_loc2_.minutes);
         }
      }
      
      private function _response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            DayActivityControl.Instance.dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEventListener("response",_response);
         _seleBtnGroup.removeEventListener("change",changeHandler);
         if(_dayActiveView)
         {
            ObjectUtils.disposeObject(_dayActiveView);
         }
         if(_dayActivityView)
         {
            ObjectUtils.disposeObject(_dayActivityView);
         }
         if(_dayActivityAdvView)
         {
            ObjectUtils.disposeObject(_dayActivityAdvView);
         }
         if(_onlineRewardView)
         {
            ObjectUtils.disposeObject(_onlineRewardView);
         }
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         _dayActivityView = null;
         _dayActiveView = null;
         _dayActivityAdvView = null;
         _onlineRewardView = null;
         super.dispose();
      }
   }
}
