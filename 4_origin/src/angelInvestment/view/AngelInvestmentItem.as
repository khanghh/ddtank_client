package angelInvestment.view
{
   import angelInvestment.data.AngelInvestmentItemData;
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.NumberImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class AngelInvestmentItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _priceBg:Bitmap;
      
      private var _info:AngelInvestmentItemData;
      
      private var _buyBtn:SimpleBitmapButton;
      
      private var _getBtn:SimpleBitmapButton;
      
      private var _number:NumberImage;
      
      private var _dayText:FilterFrameText;
      
      private var _tips:Component;
      
      private var _cell:BagCell;
      
      public function AngelInvestmentItem(param1:AngelInvestmentItemData)
      {
         super();
         _info = param1;
         init();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.angelInvestment.item" + _info.ID);
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("angelInvestment.buy");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("angelInvestment.get");
         _priceBg = ComponentFactory.Instance.creatBitmap("asset.angelInvestment.price");
         _number = ComponentFactory.Instance.creatComponentByStylename("angelInvestment.number");
         _dayText = ComponentFactory.Instance.creatComponentByStylename("angelInvestment.dayText");
         _dayText.text = LanguageMgr.GetTranslation("ddt.angelInvestment.notBuy");
         _buyBtn.addEventListener("click",__onBuy);
         _getBtn.addEventListener("click",__onGet);
         _buyBtn.enable = false;
         _tips = ComponentFactory.Instance.creatComponentByStylename("angelInvestment.itemTips");
         _tips.graphics.beginFill(0,0);
         _tips.graphics.drawRect(0,0,69,69);
         _tips.graphics.endFill();
         addChild(_bg);
         addChild(_buyBtn);
         addChild(_getBtn);
         addChild(_priceBg);
         addChild(_number);
         addChild(_dayText);
         addChild(_tips);
         _number.count = _info.Money;
         _priceBg.x = _number.x + _number.width + 10;
         _cell = new BagCell(0,ItemManager.Instance.getTemplateById(_info.GoodID));
         PositionUtils.setPos(_cell,"angelInvestment.itemCellPos");
         _cell.setCount(_info.Count);
         addChild(_cell);
         _tips.tipData = LanguageMgr.GetTranslation("ddt.angelInvestment.itmeTips",_info.Count,_cell.info.Name);
      }
      
      public function updateInfo(param1:int, param2:Boolean) : void
      {
         if(param1 >= 0)
         {
            _dayText.text = LanguageMgr.GetTranslation("ddt.angelInvestment.dayTips",param1);
            _getBtn.enable = !param2;
            _buyBtn.enable = false;
         }
      }
      
      private function __onBuy(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.angelInvestment.buyAlter",_info.Money),"",LanguageMgr.GetTranslation("cancel"),true,true,false,2);
         _loc2_.addEventListener("response",__onBuyResponse);
      }
      
      private function __onBuyResponse(param1:FrameEvent) : void
      {
         e = param1;
         var frame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__onBuyResponse);
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            CheckMoneyUtils.instance.checkMoney(false,_info.Money,function():void
            {
               _buyBtn.enable = false;
               SocketManager.Instance.out.sendAngelInvestmentBuyOne(_info.ID);
            });
         }
         frame.dispose();
      }
      
      private function __onGet(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         _getBtn.enable = false;
         SocketManager.Instance.out.sendAngelInvestmentGainOne(_info.ID);
      }
      
      public function get canGetGoods() : Boolean
      {
         return _getBtn.enable;
      }
      
      public function get canBuyGoods() : Boolean
      {
         return _buyBtn.enable;
      }
      
      public function dispose() : void
      {
         _buyBtn.removeEventListener("click",__onBuy);
         _getBtn.removeEventListener("click",__onGet);
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _buyBtn = null;
         _getBtn = null;
         _priceBg = null;
         _number = null;
         _dayText = null;
         _cell = null;
         _info = null;
         _tips = null;
      }
   }
}
