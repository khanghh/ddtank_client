package gameCommon.view.tool{   import com.greensock.TweenLite;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.LivingEvent;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import ddt.view.tips.ChangeNumToolTip;   import ddt.view.tips.ChangeNumToolTipInfo;   import ddt.view.tips.ToolPropInfo;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Shape;   import flash.display.Sprite;   import flash.events.KeyboardEvent;   import flash.events.MouseEvent;   import gameCommon.GameControl;   import gameCommon.model.LocalPlayer;   import org.aswing.KeyStroke;   import org.aswing.KeyboardManager;      public class DanderStrip extends Sprite implements Disposeable   {                   private var _specialEnabled:Boolean = true;            private var _movie:MovieClip;            private var _danderStrip:Bitmap;            private var _mask:Shape;            private var _skillBtn:Sprite;            private var _info:LocalPlayer;            private var _danderStripTip:ChangeNumToolTip;            private var _danderStripTipInfo:ChangeNumToolTipInfo;            private var _danderStripCopy:Sprite;            private var _btn:SimpleBitmapButton;            private var _btn2:SimpleBitmapButton;            private var _danderField:FilterFrameText;            private var _isDisable:Boolean;            private var _enable:Boolean = true;            public function DanderStrip() { super(); }
            private function addDanderStripTip() : void { }
            public function setInfo(info:LocalPlayer) : void { }
            private function initEvents() : void { }
            private function removeEvents() : void { }
            private function __showDanderStripTip(evt:MouseEvent) : void { }
            private function __hideDanderStripTip(evt:MouseEvent) : void { }
            private function __update(evt:LivingEvent) : void { }
            private function setDander() : void { }
            private function __updateBtn(evt:LivingEvent) : void { }
            private function __useSkill(evt:MouseEvent) : void { }
            private function __useSkill2(event:MouseEvent) : void { }
            public function disable() : void { }
            private function __keydown(event:KeyboardEvent) : void { }
            public function set specialEnabled(value:Boolean) : void { }
            public function get enable() : Boolean { return false; }
            public function set enable(value:Boolean) : void { }
            public function dispose() : void { }
   }}