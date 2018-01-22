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
      
      public function ActivityFrame(){super();}
      
      private function addEvent() : void{}
      
      public function updataBtn(param1:int) : void{}
      
      protected function changeHandler(param1:Event) : void{}
      
      private function showView(param1:int) : void{}
      
      public function setLeftView(param1:Vector.<ActivityData>, param2:Vector.<ActivityData>) : void{}
      
      public function setBar(param1:int) : void{}
      
      public function updata(param1:Array) : void{}
      
      private function initActivityFrame() : void{}
      
      protected function onUIProgress(param1:UIModuleEvent) : void{}
      
      protected function createActivityFrame(param1:UIModuleEvent) : void{}
      
      protected function onSmallLoadingClose(param1:Event) : void{}
      
      private function hideAll() : void{}
      
      private function initView() : void{}
      
      private function updateServerTime(param1:TimerEvent = null) : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
