package farm.view.compose{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.player.SelfInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.display.DisplayObject;   import flash.events.Event;   import flash.events.MouseEvent;   import petsBag.PetsBagManager;   import store.HelpFrame;      public class FarmComposeView extends Frame   {                   private var _helpBtn:BaseButton;            private var _houseBtn:SelectedButton;            private var _composeBtn:SelectedButton;            private var _btnGroup:SelectedButtonGroup;            private var _currentType:int = -1;            private var _hosePnl:FarmHousePnl;            private var _composePnl:FarmComposePnl;            private var _info:SelfInfo;            private var _titleBg:DisplayObject;            public function FarmComposeView() { super(); }
            public function get info() : SelfInfo { return null; }
            public function set info(value:SelfInfo) : void { }
            private function initView() : void { }
            private function initEvent() : void { }
            private function __frameHandler(event:FrameEvent) : void { }
            private function __composeHelp(e:MouseEvent) : void { }
            private function __changeHandler(event:Event) : void { }
            private function switchView(bool:Boolean) : void { }
            private function removeEvent() : void { }
            public function show() : void { }
            override public function dispose() : void { }
   }}