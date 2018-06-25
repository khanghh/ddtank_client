package league.view{   import battleGroud.BattleGroudControl;   import battleGroud.data.BatlleData;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.text.FilterFrameText;   import ddt.data.goods.ShopItemInfo;   import ddt.events.CEvent;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.ShopManager;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.events.MouseEvent;   import league.LeagueControl;      public class LeagueShopFrame extends Frame   {                   private var _bg:Bitmap;            private var _moneyCountTxt:FilterFrameText;            private var _pageTxt:FilterFrameText;            private var _foreBtn:SimpleBitmapButton;            private var _nextBtn:SimpleBitmapButton;            private var _shopCellList:Vector.<LeagueShopCell>;            private var _currentPage:int;            private var _totlePage:int;            private var _goodsInfoList:Vector.<ShopItemInfo>;            public function LeagueShopFrame() { super(); }
            private function initView() : void { }
            private function refreshView() : void { }
            private function refreshMoneyTxt() : void { }
            private function initEvent() : void { }
            private function __onUpdatePersonLimitShop(event:CEvent) : void { }
            private function propertyChangeHandler(event:PlayerPropertyEvent) : void { }
            private function changePageHandler(event:MouseEvent) : void { }
            private function __responseHandler(evt:FrameEvent) : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}