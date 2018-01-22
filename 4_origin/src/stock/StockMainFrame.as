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
      
      private function accountUpdate(param1:StockEvent = null) : void
      {
         lablFund.text = StringHelper.parseMoneyFormat(StockMgr.inst.model.stockAccoutData.fund);
         lablLoan.text = StringHelper.parseMoneyFormat(StockMgr.inst.model.stockAccoutData.validLoan);
      }
      
      private function removeEvent() : void
      {
         StockMgr.inst.removeEventListener("account_update",accountUpdate);
      }
      
      private function select(param1:int) : void
      {
         var _loc3_:int = param1 + 1;
         var _loc5_:Component = _views[_loc3_];
         spFundLoan.visible = _loc3_ != 3;
         var _loc4_:Array = ["","stock.marketView","stock.accountView","stock.shopView","stock.awardView"];
         if(!_loc5_)
         {
            _loc5_ = ComponentFactory.Instance.creatCustomObject(_loc4_[_loc3_]);
            _views[_loc3_] = _loc5_;
            addChild(_loc5_);
         }
         var _loc7_:int = 0;
         var _loc6_:* = _views;
         for each(var _loc2_ in _views)
         {
            if(_loc2_ && _loc2_ != _loc5_)
            {
               _loc2_.visible = false;
            }
         }
         if(_loc5_)
         {
            _loc5_.visible = true;
         }
         StockMgr.inst.chooseOperation(_loc3_);
         if(_loc3_ == 3)
         {
            SocketManager.Instance.out.sendPersonalLimitShop(117);
         }
         else if(_loc3_ == 4)
         {
            StockMgr.inst.parseStockScoreAward();
         }
      }
      
      private function help() : void
      {
         var _loc1_:StockHelpFrame = ComponentFactory.Instance.creatCustomObject("stock.helpFrame");
         LayerManager.Instance.addToLayer(_loc1_,3,false,1);
      }
      
      private function close() : void
      {
         dispose();
      }
      
      override public function dispose() : void
      {
         StockMgr.inst.chooseOperation(0);
         removeEvent();
         var _loc1_:Component = null;
         while(_views.length > 0)
         {
            _loc1_ = _views.pop();
            if(_loc1_)
            {
               _loc1_.dispose();
            }
         }
         _views = null;
         super.dispose();
      }
   }
}
