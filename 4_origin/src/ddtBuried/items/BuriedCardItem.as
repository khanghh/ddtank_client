package ddtBuried.items
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddtBuried.BuriedControl;
   import ddtBuried.BuriedManager;
   import ddtBuried.event.BuriedEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BuriedCardItem extends Sprite implements Disposeable
   {
       
      
      private var _mc:MovieClip;
      
      public var id:int;
      
      private var _tempID:int;
      
      private var _count:int;
      
      private var _isPress:Boolean;
      
      public function BuriedCardItem()
      {
         super();
         initView();
         useHandCursor = true;
         buttonMode = true;
         iniEvents();
      }
      
      private function iniEvents() : void
      {
         addEventListener("click",mouseClickHander);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("click",mouseClickHander);
      }
      
      public function setGoodsInfo(param1:int, param2:int) : void
      {
         _tempID = param1;
         _count = param2;
      }
      
      public function set isPress(param1:Boolean) : void
      {
         _isPress = param1;
      }
      
      private function mouseClickHander(param1:MouseEvent) : void
      {
         var _loc2_:int = BuriedControl.Instance.getTakeCardPay();
         SoundManager.instance.playButtonSound();
         BuriedManager.Instance.currCardIndex = id;
         if(_isPress)
         {
            return;
         }
         _isPress = true;
         this.mouseChildren = false;
         this.mouseEnabled = false;
         if(_loc2_ == 0)
         {
            SocketManager.Instance.out.takeCard();
         }
         else
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            if(BuriedManager.Instance.getRemindOverCard())
            {
               if(BuriedManager.Instance.checkMoney(BuriedManager.Instance.getRemindOverBind(),int(BuriedControl.Instance.getTakeCardPay()),SocketManager.Instance.out.takeCard))
               {
                  _isPress = false;
                  BuriedManager.Instance.setRemindOverCard(false);
                  BuriedManager.Instance.setRemindOverBind(false);
                  BuriedControl.Instance.showTransactionFrame(LanguageMgr.GetTranslation("buried.alertInfo.rollDice",_loc2_),payForCardHander,clickCallBack);
                  return;
               }
               SocketManager.Instance.out.takeCard(BuriedManager.Instance.getRemindOverBind());
               return;
            }
            BuriedControl.Instance.showTransactionFrame(LanguageMgr.GetTranslation("buried.alertInfo.rollDice",_loc2_),payForCardHander,clickCallBack,this);
            this.mouseChildren = true;
            this.mouseEnabled = true;
         }
      }
      
      private function clickCallBack(param1:Boolean) : void
      {
         BuriedManager.Instance.setRemindOverCard(param1);
      }
      
      public function play() : void
      {
         _mc.play();
         this.mouseChildren = false;
         this.mouseEnabled = false;
      }
      
      private function payForCardHander(param1:Boolean) : void
      {
         var _loc2_:int = BuriedControl.Instance.getTakeCardPay();
         if(BuriedManager.Instance.checkMoney(param1,_loc2_,SocketManager.Instance.out.takeCard))
         {
            _isPress = false;
            BuriedManager.Instance.setRemindOverCard(false);
            BuriedControl.Instance.showTransactionFrame(LanguageMgr.GetTranslation("buried.alertInfo.rollDice",_loc2_),payForCardHander,clickCallBack,this);
            return;
         }
         if(BuriedManager.Instance.getRemindOverCard())
         {
            BuriedManager.Instance.setRemindOverBind(param1);
         }
         SocketManager.Instance.out.takeCard(param1);
      }
      
      private function initView() : void
      {
         _mc = ComponentFactory.Instance.creat("buried.card.fanpai");
         _mc.x = 1;
         _mc.y = -11;
         _mc.stop();
         addChild(_mc);
         _mc.addFrameScript(80,takeOver);
         _mc.addFrameScript(9,initCard);
      }
      
      private function initCard() : void
      {
         var _loc2_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(_tempID);
         var _loc1_:BagCell = new BagCell(0,_loc2_);
         _loc1_.x = 39;
         _loc1_.y = 107;
         _loc1_.setBgVisible(false);
         _loc1_.setCount(_count);
         _mc["mc"].addChild(_loc1_);
         _mc["mc"].goodsName.text = _loc2_.Name;
      }
      
      private function takeOver() : void
      {
         if(_mc)
         {
            _mc.stop();
         }
         this.mouseEnabled = false;
         this.mouseChildren = false;
         BuriedControl.Instance.dispatchEvent(new BuriedEvent("card_take_over"));
      }
      
      public function dispose() : void
      {
         _isPress = false;
         removeEvents();
         if(_mc)
         {
            _mc.stop();
            if(_mc["mc"])
            {
               while(_mc["mc"].numChildren)
               {
                  ObjectUtils.disposeObject(_mc["mc"].getChildAt(0));
               }
            }
            while(_mc.numChildren)
            {
               ObjectUtils.disposeObject(_mc.getChildAt(0));
            }
         }
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         _mc = null;
      }
   }
}
