package catchInsect.view
{
   import ddt.command.QuickBuyFrame;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   
   public class CatchInsectQuickBuyFrameView extends QuickBuyFrame
   {
       
      
      public function CatchInsectQuickBuyFrameView()
      {
         super();
         _view.numberSelecter.visible = false;
         PositionUtils.setPos(_view.totalTipText,"catchInsect.CatchInsectQuickBuyFrameView.totalTipTextPos");
         PositionUtils.setPos(_view.totalText,"catchInsect.CatchInsectQuickBuyFrameView.totalTextPos");
      }
      
      override protected function doPay(param1:Event) : void
      {
         SoundManager.instance.play("008");
         if(_shopItemInfo == null || !_shopItemInfo.isValid)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.caddy.quickDate"));
            return;
         }
         if(_view.type == 0 || _view.type == 3)
         {
            if(_view.isBand && PlayerManager.Instance.Self.BandMoney < _view.stoneNumber * _unitPrice)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.transfer.StoreIITransferBG.lijinbuzu"));
               return;
            }
            if(!_view.isBand && PlayerManager.Instance.Self.Money < _view.stoneNumber * _unitPrice)
            {
               LeavePageManager.showFillFrame();
               return;
            }
         }
         else if(_view.type == 1)
         {
            if(!_view.isBand && PlayerManager.Instance.Self.hardCurrency < _view.stoneNumber * _unitPrice)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.view.lackCoin"));
               return;
            }
         }
         else if(_view.type == 2)
         {
            if(!_view.isBand && PlayerManager.Instance.Self.Offer < _view.stoneNumber * _unitPrice)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ConsortiaShopItem.gongXunbuzu"));
               return;
            }
         }
         if(_recordLastBuyCount)
         {
            SharedManager.Instance.lastBuyCount = _view.stoneNumber;
         }
         SocketManager.Instance.out.requestInsectWhistleBuy(_shopItemInfo.GoodsID,_view.isBand);
         dispose();
      }
   }
}
