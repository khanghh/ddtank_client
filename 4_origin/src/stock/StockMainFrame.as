package stock
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import morn.core.components.Component;
   import morn.core.handlers.Handler;
   import road7th.utils.StringHelper;
   import stock.event.StockEvent;
   import stock.mornUI.StockMainFrameUI;
   import stock.views.StockHelpFrame;
   
   public class StockMainFrame extends StockMainFrameUI
   {
       
      
      private var _views:Vector.<Component>;
      
      public function StockMainFrame()
      {
         _views = new <Component>[null,null,null,null,null];
         super();
         addEvent();
      }
      
      override protected function initialize() : void
      {
         stockText1.text = LanguageMgr.GetTranslation("ddt.stock.allView.text2");
         stockText2.text = LanguageMgr.GetTranslation("ddt.stock.allView.text3");
         tabMain.selectHandler = new Handler(select);
         btnClose.clickHandler = new Handler(close);
         btnHelp.clickHandler = new Handler(help);
         if(StockMgr.inst.operationType == 0)
         {
            tabMain.selectedIndex = 1 - 1;
         }
         else
         {
            tabMain.selectedIndex = StockMgr.inst.operationType - 1;
         }
         accountUpdate();
      }
      
      private function addEvent() : void
      {
         StockMgr.inst.addEventListener("account_update",accountUpdate);
      }
      
      private function accountUpdate(evt:StockEvent = null) : void
      {
         lablFund.text = StringHelper.parseMoneyFormat(StockMgr.inst.model.stockAccoutData.fund);
         lablLoan.text = StringHelper.parseMoneyFormat(StockMgr.inst.model.stockAccoutData.validLoan);
      }
      
      private function removeEvent() : void
      {
         StockMgr.inst.removeEventListener("account_update",accountUpdate);
      }
      
      private function select(index:int) : void
      {
         var operationType:int = index + 1;
         var view:Component = _views[operationType];
         spFundLoan.visible = operationType != 3;
         var viewCfg:Array = ["","stock.marketView","stock.accountView","stock.shopView","stock.awardView"];
         if(!view)
         {
            view = ComponentFactory.Instance.creatCustomObject(viewCfg[operationType]);
            _views[operationType] = view;
            addChild(view);
         }
         var _loc7_:int = 0;
         var _loc6_:* = _views;
         for each(var v in _views)
         {
            if(v && v != view)
            {
               v.visible = false;
            }
         }
         if(view)
         {
            view.visible = true;
         }
         StockMgr.inst.chooseOperation(operationType);
         if(operationType == 3)
         {
            SocketManager.Instance.out.sendPersonalLimitShop(117);
         }
         else if(operationType == 4)
         {
            StockMgr.inst.parseStockScoreAward();
         }
      }
      
      private function help() : void
      {
         var frame:StockHelpFrame = ComponentFactory.Instance.creatCustomObject("stock.helpFrame");
         LayerManager.Instance.addToLayer(frame,3,false,1);
      }
      
      private function close() : void
      {
         dispose();
      }
      
      override public function dispose() : void
      {
         StockMgr.inst.chooseOperation(0);
         removeEvent();
         var view:Component = null;
         while(_views.length > 0)
         {
            view = _views.pop();
            if(view)
            {
               view.dispose();
            }
         }
         _views = null;
         super.dispose();
      }
   }
}
