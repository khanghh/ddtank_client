package cityBattle.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import ddt.utils.Helpers;   import ddt.view.bossbox.AwardsGoodsList;   import flash.events.MouseEvent;      public class WinnerPrizeView extends Frame   {                   private var _infoTxt:FilterFrameText;            private var GoodsBG:ScaleBitmapImage;            private var list:AwardsGoodsList;            private var _goodsList:Array;            private var _button:TextButton;            public function WinnerPrizeView() { super(); }
            private function initView() : void { }
            private function _click(evt:MouseEvent) : void { }
            public function set goodsList(templateIds:Array) : void { }
            private function __frameEventHandler(event:FrameEvent) : void { }
            public function get goodsList() : Array { return null; }
            override public function dispose() : void { }
   }}