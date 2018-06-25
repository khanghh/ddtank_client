package store.view.shortcutBuy{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.NumberSelecter;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemPrice;   import ddt.data.goods.ShopItemInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SharedManager;   import ddt.manager.ShopManager;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;      public class ShortCutBuyView extends Sprite implements Disposeable   {            public static const ADD_NUMBER_Y:int = 40;            public static const ADD_TOTALTEXT_Y:int = 20;                   private var _templateItemIDList:Array;            private var _moneySelectBtn:SelectedCheckButton;            private var _giftSelectBtn:SelectedCheckButton;            private var _btnGroup:SelectedButtonGroup;            private var _list:ShortcutBuyList;            private var _num:NumberSelecter;            private var priceStr:String;            private var totalText:FilterFrameText;            private var totalTextBg:Image;            private var msg:FilterFrameText;            private var bg:MutipleImage;            private var _showRadioBtn:Boolean = true;            private var _memoryItemID:int;            private var _firstShow:Boolean = true;            private var _selecetMoney:SelectedCheckButton;            private var _selecetBandMoney:SelectedCheckButton;            private var _isBand:Boolean;            private var _moneyTxt:FilterFrameText;            private var _bandMoneyTxt:FilterFrameText;            public function ShortCutBuyView(templateItemIDList:Array, showRadioBtn:Boolean) { super(); }
            private function init() : void { }
            protected function selectedBandHander(event:MouseEvent) : void { }
            protected function selecetedHander(event:MouseEvent) : void { }
            private function initEvents() : void { }
            private function removeEvents() : void { }
            public function get isBand() : Boolean { return false; }
            private function _numberClose(e:Event) : void { }
            private function clickHandlerDian(e:MouseEvent) : void { }
            private function clickHandlerLi(e:MouseEvent) : void { }
            private function selectHandler(evt:Event) : void { }
            private function updateCost() : void { }
            public function get List() : ShortcutBuyList { return null; }
            public function get currentShopItem() : ShopItemInfo { return null; }
            public function get currentNum() : int { return 0; }
            public function get totalPrice() : ItemPrice { return null; }
            public function get totalMoney() : int { return 0; }
            public function get totalDDTMoney() : int { return 0; }
            public function get totalNum() : int { return 0; }
            public function save() : void { }
            public function dispose() : void { }
   }}