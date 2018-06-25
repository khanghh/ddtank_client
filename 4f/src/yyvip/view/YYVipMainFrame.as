package yyvip.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.loader.RequestLoader;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.image.ScaleBitmapImage;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.net.URLVariables;   import yyvip.YYVipManager;      public class YYVipMainFrame extends Frame   {                   private var _bg:ScaleBitmapImage;            private var _bottomBg:ScaleBitmapImage;            private var _openBtn:SelectedButton;            private var _dailyBtn:SelectedButton;            private var _btnGroup:SelectedButtonGroup;            private var _openView:YYVipOpenView;            private var _dailyView:YYVipDailyAwardView;            public function YYVipMainFrame() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function initData() : void { }
            private function __onRequestDataError(evt:LoaderEvent) : void { }
            private function __onRequestDataComplete(evt:LoaderEvent) : void { }
            private function __changeHandler(event:Event) : void { }
            private function __soundPlay(event:MouseEvent) : void { }
            private function __responseHandler(evt:FrameEvent) : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}