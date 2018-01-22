package ddtBuried.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.view.SimpleReturnBar;
   import ddtBuried.BuriedControl;
   import ddtBuried.BuriedManager;
   import ddtBuried.event.BuriedEvent;
   import ddtBuried.items.BuriedCardItem;
   import ddtBuried.items.BuriedItem;
   import ddtBuried.items.ShowCard;
   import ddtBuried.items.WashCard;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BuriedView extends Sprite implements Disposeable
   {
      
      private static const GOODSID:int = 11680;
       
      
      private var _btnList:Vector.<BuriedItem>;
      
      private var _cardList:Vector.<BuriedCardItem>;
      
      private var _iconList:Array;
      
      private var _moneyList:Array;
      
      private var _back:Bitmap;
      
      private var _shopBtn:SimpleBitmapButton;
      
      private var _startBtn:SimpleBitmapButton;
      
      private var _showCard:ShowCard;
      
      private var _washCard:WashCard;
      
      private var _cardContent:Sprite;
      
      private var _returnBtn:SimpleReturnBar;
      
      private var _fileTxt:FilterFrameText;
      
      private var _wordBack:Bitmap;
      
      public function BuriedView()
      {
         _iconList = ["buried.stone","buried.bindMoney","buried.money"];
         _moneyList = [BuriedManager.Instance.getBuriedStoneNum(),PlayerManager.Instance.Self.Money.toString(),PlayerManager.Instance.Self.BandMoney.toString()];
         super();
         _btnList = new Vector.<BuriedItem>();
         _cardList = new Vector.<BuriedCardItem>();
         initView();
         initEvents();
      }
      
      private function initEvents() : void
      {
         _startBtn.addEventListener("click",startHandler);
         _shopBtn.addEventListener("click",openShopHander);
         BuriedControl.Instance.addEventListener("card_show_over",cardShowOverHander);
         BuriedControl.Instance.addEventListener("card_wash_start",cardWashStartHander);
         BuriedControl.Instance.addEventListener("card_wash_over",cardWashHander);
         BuriedManager.Instance.addEventListener("take_card",cardTakeHander);
         BuriedManager.Instance.addEventListener("buried_UpDate_Stone_Count",upDateStoneHander);
         PlayerManager.Instance.Self.addEventListener("propertychange",onUpdate);
      }
      
      private function removeEvents() : void
      {
         _shopBtn.removeEventListener("click",openShopHander);
         _startBtn.removeEventListener("click",startHandler);
         BuriedManager.Instance.removeEventListener("buried_UpDate_Stone_Count",upDateStoneHander);
         PlayerManager.Instance.Self.removeEventListener("propertychange",onUpdate);
         BuriedControl.Instance.removeEventListener("card_show_over",cardShowOverHander);
         BuriedControl.Instance.removeEventListener("card_wash_start",cardWashStartHander);
         BuriedControl.Instance.removeEventListener("card_wash_over",cardWashHander);
         BuriedManager.Instance.removeEventListener("take_card",cardTakeHander);
      }
      
      private function upDateStoneHander(param1:BuriedEvent) : void
      {
         _btnList[0].upDateTxt(BuriedManager.Instance.getBuriedStoneNum());
      }
      
      private function openShopHander(param1:MouseEvent) : void
      {
         BuriedControl.Instance.openshopHander();
         SoundManager.instance.playButtonSound();
      }
      
      private function onUpdate(param1:PlayerPropertyEvent) : void
      {
         _btnList[1].upDateTxt(PlayerManager.Instance.Self.Money.toString());
         _btnList[2].upDateTxt(PlayerManager.Instance.Self.BandMoney.toString());
      }
      
      private function returnToDice(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
      }
      
      private function cardTakeHander(param1:BuriedEvent) : void
      {
         var _loc2_:Object = param1.data;
         _cardList[BuriedManager.Instance.currCardIndex].play();
         _cardList[BuriedManager.Instance.currCardIndex].setGoodsInfo(param1.data.tempID,param1.data.count);
      }
      
      private function cardWashStartHander(param1:BuriedEvent) : void
      {
         if(!_washCard)
         {
            _washCard = new WashCard();
            addChild(_washCard);
         }
         _washCard.visible = true;
         _washCard.play();
      }
      
      private function cardWashHander(param1:BuriedEvent) : void
      {
         _cardContent.visible = true;
         if(_washCard)
         {
            _washCard.visible = false;
            _washCard.resetFrame();
         }
      }
      
      private function cardShowOverHander(param1:BuriedEvent) : void
      {
         _startBtn.mouseEnabled = true;
      }
      
      private function startHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         _startBtn.mouseEnabled = false;
         _startBtn.visible = false;
         _showCard.visible = false;
         if(!_washCard)
         {
            _washCard = new WashCard();
            _washCard.x = 492;
            _washCard.y = 242;
            addChild(_washCard);
         }
         _washCard.visible = true;
         _washCard.play();
      }
      
      private function initView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc1_:* = null;
         _back = ComponentFactory.Instance.creat("buried.open.back");
         addChild(_back);
         _shopBtn = ComponentFactory.Instance.creatComponentByStylename("buried.shopBtn");
         addChild(_shopBtn);
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("buried.findBtn");
         addChild(_startBtn);
         _startBtn.mouseEnabled = false;
         _wordBack = ComponentFactory.Instance.creat("buried.word.back");
         _wordBack.x = 150;
         _wordBack.y = 360;
         addChild(_wordBack);
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc2_ = new BuriedItem(_moneyList[_loc4_],_iconList[_loc4_]);
            _loc2_.x = (_loc2_.width + 4) * _loc4_ + 139;
            _loc2_.y = 554;
            addChild(_loc2_);
            _btnList.push(_loc2_);
            _loc4_++;
         }
         _cardContent = new Sprite();
         _cardContent.x = 101;
         _cardContent.y = 118;
         _cardContent.visible = false;
         addChild(_cardContent);
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc1_ = new BuriedCardItem();
            _loc1_.id = _loc3_;
            _loc1_.x = (_loc1_.width + 19) * _loc3_;
            _cardContent.addChild(_loc1_);
            _cardList.push(_loc1_);
            _loc3_++;
         }
         _showCard = new ShowCard();
         _showCard.x = 493;
         _showCard.y = 306;
         addChild(_showCard);
         _returnBtn = ComponentFactory.Instance.creatCustomObject("asset.simpleReturnBar.Button");
         _returnBtn.returnCall = exitHandler;
         _returnBtn.x = 909;
         _returnBtn.y = 541;
         addChild(_returnBtn);
         _fileTxt = ComponentFactory.Instance.creatComponentByStylename("ddtburied.view.descriptTxt");
         _fileTxt.text = LanguageMgr.GetTranslation("buried.alertInfo.buriedAtion");
         addChild(_fileTxt);
      }
      
      private function exitHandler() : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
      }
      
      private function clearCardItem() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _cardList.length)
         {
            _cardList[_loc1_].dispose();
            ObjectUtils.disposeObject(_cardList[_loc1_]);
            _cardList[_loc1_] = null;
            _loc1_++;
         }
      }
      
      private function clearBtnList() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _btnList.length)
         {
            _btnList[_loc1_].dispose();
            ObjectUtils.disposeObject(_btnList[_loc1_]);
            _btnList[_loc1_] = null;
            _loc1_++;
         }
      }
      
      public function dispose() : void
      {
         removeEvents();
         BuriedManager.Instance.currCardIndex = 0;
         if(_cardList)
         {
            clearCardItem();
         }
         if(_btnList)
         {
            clearBtnList();
         }
         _showCard.dispose();
         if(_washCard)
         {
            _washCard.dispose();
         }
         _returnBtn.dispose();
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         _cardList = null;
         _btnList = null;
      }
   }
}
