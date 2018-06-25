package totem.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import flash.display.Sprite;      public class TotemLeftWindowPropertyTxtView extends Sprite implements Disposeable   {                   private var _levelTxtList:Vector.<FilterFrameText>;            private var _txtArray:Array;            public function TotemLeftWindowPropertyTxtView() { super(); }
            public function show(location:Array) : void { }
            public function refreshLayer(level:int) : void { }
            public function scaleTxt(scale:Number) : void { }
            public function dispose() : void { }
   }}