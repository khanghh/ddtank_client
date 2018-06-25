package gameCommon.view{   import com.greensock.TweenLite;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import flash.display.Bitmap;   import flash.events.MouseEvent;      public class DreamLandDamageLogView extends DreamLandLogBaseView   {                   private var _damageBtn:TextButton;            private var _bg:Bitmap;            private var _openFlag:Boolean = false;            public function DreamLandDamageLogView() { super(); }
            override protected function initView() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            protected function __onMouseClick(event:MouseEvent) : void { }
            override public function updateView(hurts:Array) : void { }
            override public function dispose() : void { }
   }}