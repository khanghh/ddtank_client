package AvatarCollection.view{   import AvatarCollection.AvatarCollectionManager;   import AvatarCollection.data.AvatarCollectionUnitVo;   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.CEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import times.utils.timerManager.TimerJuggler;   import times.utils.timerManager.TimerManager;      public class AvatarCollectionTimeView extends Sprite implements Disposeable   {                   private var _txt:FilterFrameText;            private var _btnDelayTime:SimpleBitmapButton;            private var _btnSelectAll:SimpleBitmapButton;            private var _btnUnSelectAll:SimpleBitmapButton;            private var _timer:TimerJuggler;            private var _data:AvatarCollectionUnitVo;            private var _needHonor:int;            public function AvatarCollectionTimeView() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            protected function onSetSelectedAll(e:CEvent) : void { }
            protected function unSelectAllClickHandler(e:MouseEvent) : void { }
            protected function selectAllClickHandler(e:MouseEvent) : void { }
            public function onSelectChange() : void { }
            public function set selected(value:Boolean) : void { }
            private function delayTimeClickHandler(event:MouseEvent) : void { }
            protected function __onConfirmResponse(event:FrameEvent) : void { }
            private function initTimer() : void { }
            private function timerHandler(event:Event) : void { }
            public function refreshView(data:AvatarCollectionUnitVo) : void { }
            private function refreshTimePlayTxt() : void { }
            private function setDefaultView() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}