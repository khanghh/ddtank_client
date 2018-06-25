package gameCommon.view{   import com.greensock.TweenLite;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.text.FilterFrameText;   import ddt.manager.LanguageMgr;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import gameCommon.GameControl;   import gameCommon.model.Living;      public class DamageView extends Sprite   {                   private var _viewDamageBtn:BaseButton;            private var _infoSprite:Sprite;            private var _bg:Bitmap;            private var _title:FilterFrameText;            private var _listTxt:FilterFrameText;            private var _userNameVec:Vector.<FilterFrameText>;            private var _damageNumVec:Vector.<FilterFrameText>;            private var _openFlag:Boolean = false;            public function DamageView() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            public function updateView() : void { }
            private function clearTextInfo() : void { }
            protected function __onMouseClick(event:MouseEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}