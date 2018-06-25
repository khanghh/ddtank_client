package worldcup.view
{
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import morn.core.handlers.Handler;
   import worldcup.WorldcupManager;
   import worldcup.view.item.PrizeItem;
   import worldcup.view.mornui.PrizeViewUI;
   
   public class PrizeView extends PrizeViewUI
   {
       
      
      public function PrizeView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         txt1.text = LanguageMgr.GetTranslation("ddt.worldcupGuess.prizeView.text1");
         txt2.text = LanguageMgr.GetTranslation("ddt.worldcupGuess.prizeView.text2");
         txt3.text = LanguageMgr.GetTranslation("ddt.worldcupGuess.prizeView.text3");
         txt4.text = LanguageMgr.GetTranslation("ddt.worldcupGuess.prizeView.text4");
         totalNumTxt.text = String(WorldcupManager.instance.model.totalRecharge);
         listPrize.renderHandler = new Handler(render);
         listPrize.array = toArray();
         WorldcupManager.instance.addEventListener(WorldcupManager.GET_PRIZE_OK,__getPrizeHandler);
      }
      
      private function toArray() : Array
      {
         var i:int = 0;
         var tmp:Array = [];
         for(i = 0; i < ServerConfigManager.instance.worldcupAwardCount.length; )
         {
            tmp.push(i);
            i++;
         }
         return tmp;
      }
      
      private function __getPrizeHandler(evt:CEvent) : void
      {
         listPrize.refresh();
      }
      
      private function render(item:PrizeItem, index:int) : void
      {
         item.index = index;
      }
      
      override public function dispose() : void
      {
         WorldcupManager.instance.removeEventListener(WorldcupManager.GET_PRIZE_OK,__getPrizeHandler);
         super.dispose();
      }
   }
}
