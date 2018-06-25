package floatParade.views{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.utils.setTimeout;   import floatParade.FloatParadeEvent;   import floatParade.FloatParadeManager;      public class FloatParadeThreeBtnView extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _leapBtn:SimpleBitmapButton;            private var _invisibilityBtn:SimpleBitmapButton;            private var _cleanBtn:SimpleBitmapButton;            private var _missileBtn:SimpleBitmapButton;            private var _recordClickTag:int;            private var _freeTipList:Vector.<MovieClip>;            public var targetId:int = 0;            public var targetZone:int = -1;            public function FloatParadeThreeBtnView() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function refreshFreeCount(event:Event) : void { }
            private function outHandler(event:MouseEvent) : void { }
            private function overHandler(event:MouseEvent) : void { }
            private function enableBtn(btn:SimpleBitmapButton) : void { }
            private function unEnableBtn(tag:int) : void { }
            private function clickHandler(event:MouseEvent) : void { }
            public function useSkill() : void { }
            private function useSkillConfirm(evt:FrameEvent) : void { }
            private function useSkillReConfirm(evt:FrameEvent) : void { }
            private function sendUseSkillSocket(type:int, isBand:Boolean, isFree:Boolean, otherId:int = 0, otherZone:int = -1) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}