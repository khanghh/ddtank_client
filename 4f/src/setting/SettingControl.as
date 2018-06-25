package setting{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import ddt.events.CEvent;   import ddt.manager.SharedManager;   import ddt.utils.HelperUIModuleLoad;   import flash.events.Event;   import setting.controll.SettingController;   import setting.view.SettingView;      public class SettingControl   {            private static var _instance:SettingControl;                   private var _settingView:SettingView;            public function SettingControl() { super(); }
            public static function get instance() : SettingControl { return null; }
            public function setup() : void { }
            private function __onOpenView(e:CEvent) : void { }
            private function loadComplete() : void { }
            protected function onViewRemove(e:Event) : void { }
            private function __onCloseView(e:CEvent) : void { }
            private function __responseHandler(evt:FrameEvent) : void { }
            public function hide() : void { }
   }}