package farm.viewx.shop{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.text.FilterFrameText;   import ddt.view.tips.GoodTip;      public class FarmShopTips extends GoodTip   {                   private var _limitTips:String;            public function FarmShopTips() { super(); }
            override public function set tipData(data:Object) : void { }
            public function limitTips(value:String) : void { }
            override protected function updateView() : void { }
            private function createLimitTips() : void { }
   }}