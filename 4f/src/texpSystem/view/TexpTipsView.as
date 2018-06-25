package texpSystem.view{   import com.pickgliss.ui.tip.BaseTip;   import com.pickgliss.utils.ObjectUtils;   import morn.core.components.Label;   import texpSystem.controller.TexpManager;   import texpSystem.data.TexpInfo;   import texpSystem.view.mornui.TexpTipsViewUI;      public class TexpTipsView extends BaseTip   {                   private var _tipsUI:TexpTipsViewUI;            public function TexpTipsView() { super(); }
            private function updateView() : void { }
            override public function set tipData(value:Object) : void { }
            override public function get width() : Number { return 0; }
            override public function get height() : Number { return 0; }
            override public function dispose() : void { }
   }}