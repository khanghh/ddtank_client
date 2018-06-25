package dayActivity{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.UICreatShortcut;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.ISelectable;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import dayActivity.view.DayActiveView;   import dayActivity.view.DayActivityAdvView;   import dayActivity.view.DayActivityView;   import dayActivity.view.OnlineRewardView;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddt.utils.PositionUtils;   import ddt.view.UIModuleSmallLoading;   import flash.events.Event;   import flash.events.TimerEvent;   import flash.utils.Timer;   import times.TimesManager;      public class ActivityFrame extends Frame implements Disposeable   {                   private var _dayActivityBtn:SelectedButton;            private var _dayActiveBtn:SelectedButton;            private var _dayActivityAdvBtn:SelectedButton;            private var _onLineRewardBtn:SelectedButton;            private var _seleBtnGroup:SelectedButtonGroup;            private var _treeImage:ScaleBitmapImage;            private var _dayActivityView:DayActivityView;            private var _dayActiveView:DayActiveView;            private var _dayActivityAdvView:DayActivityAdvView;            private var _onlineRewardView:OnlineRewardView;            private var _serverTimeTxt:FilterFrameText;            private var _serverTimeTxtStr:String;            private var _serverTimer:Timer;            public function ActivityFrame() { super(); }
            private function addEvent() : void { }
            public function updataBtn(num:int) : void { }
            protected function changeHandler(event:Event) : void { }
            private function showView(type:int) : void { }
            public function setLeftView(overList:Vector.<ActivityData>, noOverList:Vector.<ActivityData>) : void { }
            public function setBar(num:int) : void { }
            public function updata(arr:Array) : void { }
            private function initActivityFrame() : void { }
            protected function onUIProgress(event:UIModuleEvent) : void { }
            protected function createActivityFrame(event:UIModuleEvent) : void { }
            protected function onSmallLoadingClose(event:Event) : void { }
            private function hideAll() : void { }
            private function initView() : void { }
            private function updateServerTime(evt:TimerEvent = null) : void { }
            private function _response(evt:FrameEvent) : void { }
            override public function dispose() : void { }
   }}