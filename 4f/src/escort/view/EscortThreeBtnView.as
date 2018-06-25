package escort.view{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import escort.EscortControl;   import escort.EscortManager;   import escort.event.EscortEvent;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.utils.setTimeout;      public class EscortThreeBtnView extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _leapBtn:SimpleBitmapButton;            private var _invisibilityBtn:SimpleBitmapButton;            private var _cleanBtn:SimpleBitmapButton;            private var _recordClickTag:int;            private var _freeTipList:Vector.<MovieClip>;            public function EscortThreeBtnView() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function refreshFreeCount(event:Event) : void { }
            private function outHandler(event:MouseEvent) : void { }
            private function overHandler(event:MouseEvent) : void { }
            private function enableBtn(btn:SimpleBitmapButton) : void { }
            private function unEnableBtn(tag:int) : void { }
            private function clickHandler(event:MouseEvent) : void { }
            private function useSkillConfirm(evt:FrameEvent) : void { }
            private function useSkillReConfirm(evt:FrameEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}