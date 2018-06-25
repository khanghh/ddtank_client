package gameStarling.view.buff.tips{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.view.tips.BaseBuffPropertyTip;      public class TrialBuffTip extends BaseBuffPropertyTip   {                   private var _proTxt:FilterFrameText;            public function TrialBuffTip() { super(); }
            override public function set tipData(data:Object) : void { }
            override protected function getProName() : Array { return null; }
            override public function dispose() : void { }
   }}