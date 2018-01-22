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
      
      public function StockMainFrame(){super();}
      
      override protected function initialize() : void{}
      
      private function addEvent() : void{}
      
      private function accountUpdate(param1:StockEvent = null) : void{}
      
      private function removeEvent() : void{}
      
      private function select(param1:int) : void{}
      
      private function help() : void{}
      
      private function close() : void{}
      
      override public function dispose() : void{}
   }
}
