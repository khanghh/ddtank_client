package ddtBuried.views{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.view.SimpleReturnBar;   import ddtBuried.BuriedControl;   import ddtBuried.BuriedManager;   import ddtBuried.event.BuriedEvent;   import ddtBuried.items.BuriedCardItem;   import ddtBuried.items.BuriedItem;   import ddtBuried.items.ShowCard;   import ddtBuried.items.WashCard;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class BuriedView extends Sprite implements Disposeable   {            private static const GOODSID:int = 11680;                   private var _btnList:Vector.<BuriedItem>;            private var _cardList:Vector.<BuriedCardItem>;            private var _iconList:Array;            private var _moneyList:Array;            private var _back:Bitmap;            private var _shopBtn:SimpleBitmapButton;            private var _startBtn:SimpleBitmapButton;            private var _showCard:ShowCard;            private var _washCard:WashCard;            private var _cardContent:Sprite;            private var _returnBtn:SimpleReturnBar;            private var _fileTxt:FilterFrameText;            private var _wordBack:Bitmap;            public function BuriedView() { super(); }
            private function initEvents() : void { }
            private function removeEvents() : void { }
            private function upDateStoneHander(e:BuriedEvent) : void { }
            private function openShopHander(e:MouseEvent) : void { }
            private function onUpdate(e:PlayerPropertyEvent) : void { }
            private function returnToDice(e:MouseEvent) : void { }
            private function cardTakeHander(e:BuriedEvent) : void { }
            private function cardWashStartHander(e:BuriedEvent) : void { }
            private function cardWashHander(e:BuriedEvent) : void { }
            private function cardShowOverHander(e:BuriedEvent) : void { }
            private function startHandler(e:MouseEvent) : void { }
            private function initView() : void { }
            private function exitHandler() : void { }
            private function clearCardItem() : void { }
            private function clearBtnList() : void { }
            public function dispose() : void { }
   }}