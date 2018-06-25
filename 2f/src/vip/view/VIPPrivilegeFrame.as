package vip.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Image;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;      public class VIPPrivilegeFrame extends Frame   {                   private var _bg:Image;            private var _view:Sprite;            private var _currentViewIndex:int = -1;            private var _growthRules:SelectedButton;            private var _levelPrivilege:SelectedButton;            private var _selectedBtnGroup:SelectedButtonGroup;            private var _openVipBtn:BaseButton;            public function VIPPrivilegeFrame() { super(); }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            protected function __frameEventHandler(event:FrameEvent) : void { }
            private function initView() : void { }
            protected function __onOpenVipBtnClick(event:MouseEvent) : void { }
            protected function __onSelectedBtnChanged(event:Event) : void { }
            private function updateView(index:int) : void { }
            override public function dispose() : void { }
   }}