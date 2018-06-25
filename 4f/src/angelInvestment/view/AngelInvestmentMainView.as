package angelInvestment.view{   import angelInvestment.AngelInvestmentManager;   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.image.NumberImage;   import com.pickgliss.ui.text.FilterFrameText;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.CheckMoneyUtils;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.events.MouseEvent;   import flash.utils.getTimer;   import road7th.comm.PackageIn;      public class AngelInvestmentMainView extends Frame   {                   private const COUNT:int = 7;            private var _itemList:Vector.<AngelInvestmentItem>;            private var _helpText:FilterFrameText;            private var _buyAllBtn:SimpleBitmapButton;            private var _getAllBtn:SimpleBitmapButton;            private var _day:NumberImage;            private var _price:NumberImage;            private var _textBg:Bitmap;            private var _clickTime:Number;            public function AngelInvestmentMainView() { super(); }
            public function show() : void { }
            override protected function init() : void { }
            override protected function addChildren() : void { }
            private function __onClickBuyAll(e:MouseEvent) : void { }
            private function __onBuyAllResponse(e:FrameEvent) : void { }
            private function __onClickGetAll(e:MouseEvent) : void { }
            private function isAllGet() : Boolean { return false; }
            private function isAllBuy() : Boolean { return false; }
            private function initItem() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            protected function onUpdateItems(e:PkgEvent) : void { }
            override protected function onFrameClose() : void { }
            override public function dispose() : void { }
   }}