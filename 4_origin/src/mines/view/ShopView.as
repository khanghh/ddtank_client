package mines.view
{
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   import mines.MinesManager;
   import mines.analyzer.ShopDropInfo;
   import mines.analyzer.ShopExchangeInfo;
   import mines.mornui.view.ShopViewUI;
   
   public class ShopView extends ShopViewUI
   {
       
      
      private var box:Sprite;
      
      private var box1:Sprite;
      
      private var list:Vector.<MinesBuyCell>;
      
      private var list1:Vector.<MinesExchangeCell>;
      
      public function ShopView()
      {
         box = new Sprite();
         box1 = new Sprite();
         super();
      }
      
      override protected function initialize() : void
      {
         var i:int = 0;
         var dropInfo:* = null;
         var cell:* = null;
         var j:int = 0;
         var exchangeInfo:* = null;
         var cell1:* = null;
         list = new Vector.<MinesBuyCell>();
         list1 = new Vector.<MinesExchangeCell>();
         infoLabel.text = LanguageMgr.GetTranslation("ddt.mines.shopView.info");
         for(i = 0; i < MinesManager.instance.model.shopDropList.length; )
         {
            dropInfo = MinesManager.instance.model.shopDropList[i];
            cell = new MinesBuyCell();
            cell.info = dropInfo;
            cell.x = 136 + 75 * i;
            cell.y = 273;
            box.addChild(cell);
            list.push(cell);
            i++;
         }
         for(j = 0; j < MinesManager.instance.model.shopExchangeList.length; )
         {
            exchangeInfo = MinesManager.instance.model.shopExchangeList[j];
            cell1 = new MinesExchangeCell();
            cell1.infoExchange = exchangeInfo;
            cell1.x = 136 + 75 * j;
            cell1.y = 402;
            box1.addChild(cell1);
            list1.push(cell1);
            j++;
         }
         addChild(box);
         addChild(box1);
      }
      
      public function updataList() : void
      {
         var i:int = 0;
         var dropInfo:* = null;
         var j:int = 0;
         var exchangeInfo:* = null;
         for(i = 0; i < list.length; )
         {
            dropInfo = MinesManager.instance.model.shopDropList[i];
            list[i].info = dropInfo;
            i++;
         }
         for(j = 0; j < list1.length; )
         {
            exchangeInfo = MinesManager.instance.model.shopExchangeList[j];
            list1[j].infoExchange = exchangeInfo;
            j++;
         }
      }
   }
}
