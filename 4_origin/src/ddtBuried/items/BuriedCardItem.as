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
      
      public function setGoodsInfo(id:int, count:int) : void
      {
         _tempID = id;
         _count = count;
      }
      
      public function set isPress(bool:Boolean) : void
      {
         _isPress = bool;
      }
      
      private function mouseClickHander(event:MouseEvent) : void
      {
         var money:int = BuriedControl.Instance.getTakeCardPay();
         SoundManager.instance.playButtonSound();
         BuriedManager.Instance.currCardIndex = id;
         if(_isPress)
         {
            return;
         }
         _isPress = true;
         this.mouseChildren = false;
         this.mouseEnabled = false;
         if(money == 0)
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
                  BuriedControl.Instance.showTransactionFrame(LanguageMgr.GetTranslation("buried.alertInfo.rollDice",money),payForCardHander,clickCallBack);
                  return;
               }
               SocketManager.Instance.out.takeCard(BuriedManager.Instance.getRemindOverBind());
               return;
            }
            BuriedControl.Instance.showTransactionFrame(LanguageMgr.GetTranslation("buried.alertInfo.rollDice",money),payForCardHander,clickCallBack,this);
            this.mouseChildren = true;
            this.mouseEnabled = true;
         }
      }
      
      private function clickCallBack(bool:Boolean) : void
      {
         BuriedManager.Instance.setRemindOverCard(bool);
      }
      
      public function play() : void
      {
         _mc.play();
         this.mouseChildren = false;
         this.mouseEnabled = false;
      }
      
      private function payForCardHander(bool:Boolean) : void
      {
         var money:int = BuriedControl.Instance.getTakeCardPay();
         if(BuriedManager.Instance.checkMoney(bool,money,SocketManager.Instance.out.takeCard))
         {
            _isPress = false;
            BuriedManager.Instance.setRemindOverCard(false);
            BuriedControl.Instance.showTransactionFrame(LanguageMgr.GetTranslation("buried.alertInfo.rollDice",money),payForCardHander,clickCallBack,this);
            return;
         }
         if(BuriedManager.Instance.getRemindOverCard())
         {
            BuriedManager.Instance.setRemindOverBind(bool);
         }
         SocketManager.Instance.out.takeCard(bool);
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
         var info:ItemTemplateInfo = ItemManager.Instance.getTemplateById(_tempID);
         var cell:BagCell = new BagCell(0,info);
         cell.x = 39;
         cell.y = 107;
         cell.setBgVisible(false);
         cell.setCount(_count);
         _mc["mc"].addChild(cell);
         _mc["mc"].goodsName.text = info.Name;
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
