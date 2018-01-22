package angelInvestment.view
{
   import angelInvestment.AngelInvestmentManager;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.NumberImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import road7th.comm.PackageIn;
   
   public class AngelInvestmentMainView extends Frame
   {
       
      
      private const COUNT:int = 7;
      
      private var _itemList:Vector.<AngelInvestmentItem>;
      
      private var _helpText:FilterFrameText;
      
      private var _buyAllBtn:SimpleBitmapButton;
      
      private var _getAllBtn:SimpleBitmapButton;
      
      private var _day:NumberImage;
      
      private var _price:NumberImage;
      
      private var _textBg:Bitmap;
      
      private var _clickTime:Number;
      
      public function AngelInvestmentMainView()
      {
         super();
      }
      
      public function show() : void
      {
         SocketManager.Instance.out.sendAngelInvestmentUpdate();
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      override protected function init() : void
      {
         _textBg = ComponentFactory.Instance.creatBitmap("asset.angelInvestment.textBg");
         _helpText = ComponentFactory.Instance.creatComponentByStylename("angelInvestment.helpText");
         _helpText.htmlText = LanguageMgr.GetTranslation("ddt.angelInvestment.help");
         _buyAllBtn = ComponentFactory.Instance.creatComponentByStylename("angelInvestment.buyAll");
         _buyAllBtn.addEventListener("click",__onClickBuyAll);
         _buyAllBtn.enable = false;
         _getAllBtn = ComponentFactory.Instance.creatComponentByStylename("angelInvestment.getAll");
         _getAllBtn.addEventListener("click",__onClickGetAll);
         _price = ComponentFactory.Instance.creatComponentByStylename("angelInvestment.priceNumber");
         _day = ComponentFactory.Instance.creatComponentByStylename("angelInvestment.priceNumber");
         PositionUtils.setPos(_price,"angelInvestment.framePricePos");
         PositionUtils.setPos(_day,"angelInvestment.frameDayPos");
         _day.count = ServerConfigManager.instance.angelInvestmentDay;
         _price.count = ServerConfigManager.instance.angelInvestmentAllPrice;
         initItem();
         super.init();
         initEvent();
      }
      
      override protected function addChildren() : void
      {
         var _loc1_:int = 0;
         super.addChildren();
         if(_buyAllBtn)
         {
            addToContent(_buyAllBtn);
         }
         if(_getAllBtn)
         {
            addToContent(_getAllBtn);
         }
         if(_helpText)
         {
            addToContent(_helpText);
         }
         if(_textBg)
         {
            addToContent(_textBg);
         }
         if(_price)
         {
            addToContent(_price);
         }
         if(_day)
         {
            addToContent(_day);
         }
         if(_itemList && _itemList.length)
         {
            _loc1_ = 0;
            while(_loc1_ < 7)
            {
               addToContent(_itemList[_loc1_]);
               _loc1_++;
            }
         }
      }
      
      private function __onClickBuyAll(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(!isAllBuy())
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.angelInvestment.buyAllAlter",ServerConfigManager.instance.angelInvestmentAllPrice),"",LanguageMgr.GetTranslation("cancel"),true,true,false,2);
            _loc2_.addEventListener("response",__onBuyAllResponse);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.angelInvestment.notAllBuy"));
         }
      }
      
      private function __onBuyAllResponse(param1:FrameEvent) : void
      {
         e = param1;
         var frame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__onBuyAllResponse);
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            CheckMoneyUtils.instance.checkMoney(false,ServerConfigManager.instance.angelInvestmentAllPrice,function():void
            {
               SocketManager.Instance.out.sendAngelInvestmentBuyAll();
            });
         }
         frame.dispose();
      }
      
      private function __onClickGetAll(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(getTimer() - _clickTime < 3000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("carnival.clickTip"));
            return;
         }
         _clickTime = getTimer();
         if(!isAllGet())
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            SocketManager.Instance.out.sendAngelInvestmentGainAll();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.angelInvestment.notAllGet"));
         }
      }
      
      private function isAllGet() : Boolean
      {
         var _loc1_:int = 0;
         if(_itemList && _itemList.length)
         {
            _loc1_ = 0;
            while(_loc1_ < 7)
            {
               if(_itemList[_loc1_].canGetGoods)
               {
                  return false;
               }
               _loc1_++;
            }
         }
         return true;
      }
      
      private function isAllBuy() : Boolean
      {
         var _loc1_:int = 0;
         if(_itemList && _itemList.length)
         {
            _loc1_ = 0;
            while(_loc1_ < 7)
            {
               if(_itemList[_loc1_].canBuyGoods)
               {
                  return false;
               }
               _loc1_++;
            }
         }
         return true;
      }
      
      private function initItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _itemList = new Vector.<AngelInvestmentItem>(7);
         _loc2_ = 1;
         while(_loc2_ <= 7)
         {
            _loc1_ = new AngelInvestmentItem(AngelInvestmentManager.instance.model.data[_loc2_]);
            PositionUtils.setPos(_loc1_,"angelInvestment.itemPos" + _loc2_);
            _itemList[_loc2_ - 1] = _loc1_;
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(357,1),onUpdateItems);
      }
      
      private function removeEvent() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(357,1),onUpdateItems);
      }
      
      protected function onUpdateItems(param1:PkgEvent) : void
      {
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:Boolean = false;
         var _loc4_:PackageIn = param1.pkg;
         var _loc3_:int = _loc4_.readInt();
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc2_ = _loc4_.readInt();
            _loc6_ = _loc4_.readInt();
            _loc5_ = _loc4_.readBoolean();
            _itemList[_loc2_ - 1].updateInfo(_loc6_,_loc5_);
            _loc7_++;
         }
         _buyAllBtn.visible = !isAllBuy();
      }
      
      override protected function onFrameClose() : void
      {
         SoundManager.instance.playButtonSound();
         this.dispose();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _itemList.splice(0,_itemList.length);
         super.dispose();
         _itemList = null;
         _helpText = null;
         _buyAllBtn = null;
         _getAllBtn = null;
         _price = null;
         _textBg = null;
         _day = null;
      }
   }
}
