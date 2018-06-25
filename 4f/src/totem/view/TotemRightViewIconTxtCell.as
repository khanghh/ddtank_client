package totem.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.text.TextFormat;      public class TotemRightViewIconTxtCell extends Sprite implements Disposeable   {                   private var _iconComponent:Component;            private var _icon:Bitmap;            private var _txt:FilterFrameText;            private var _lineSp:Sprite;            public function TotemRightViewIconTxtCell() { super(); }
            public function show(type:int) : void { }
            public function refresh(value:int, isChangeColor:Boolean = false) : void { }
            public function rawTextLine() : void { }
            public function clearTextLine() : void { }
            public function dispose() : void { }
   }}