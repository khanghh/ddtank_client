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
         var i:int = 0;
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
            for(i = 0; i < 7; )
            {
               addToContent(_itemList[i]);
               i++;
            }
         }
      }
      
      private function __onClickBuyAll(e:MouseEvent) : void
      {
         var frame:* = null;
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(!isAllBuy())
         {
            frame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.angelInvestment.buyAllAlter",ServerConfigManager.instance.angelInvestmentAllPrice),"",LanguageMgr.GetTranslation("cancel"),true,true,false,2);
            frame.addEventListener("response",__onBuyAllResponse);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.angelInvestment.notAllBuy"));
         }
      }
      
      private function __onBuyAllResponse(e:FrameEvent) : void
      {
         e = e;
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
      
      private function __onClickGetAll(e:MouseEvent) : void
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
         var i:int = 0;
         if(_itemList && _itemList.length)
         {
            for(i = 0; i < 7; )
            {
               if(_itemList[i].canGetGoods)
               {
                  return false;
               }
               i++;
            }
         }
         return true;
      }
      
      private function isAllBuy() : Boolean
      {
         var i:int = 0;
         if(_itemList && _itemList.length)
         {
            for(i = 0; i < 7; )
            {
               if(_itemList[i].canBuyGoods)
               {
                  return false;
               }
               i++;
            }
         }
         return true;
      }
      
      private function initItem() : void
      {
         var i:int = 0;
         var item:* = null;
         _itemList = new Vector.<AngelInvestmentItem>(7);
         for(i = 1; i <= 7; )
         {
            item = new AngelInvestmentItem(AngelInvestmentManager.instance.model.data[i]);
            PositionUtils.setPos(item,"angelInvestment.itemPos" + i);
            _itemList[i - 1] = item;
            i++;
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
      
      protected function onUpdateItems(e:PkgEvent) : void
      {
         var i:int = 0;
         var id:int = 0;
         var day:int = 0;
         var isGet:Boolean = false;
         var pkg:PackageIn = e.pkg;
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            id = pkg.readInt();
            day = pkg.readInt();
            isGet = pkg.readBoolean();
            _itemList[id - 1].updateInfo(day,isGet);
            i++;
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
