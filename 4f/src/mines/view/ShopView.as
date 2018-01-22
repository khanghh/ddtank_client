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
      
      public function ShopView(){super();}
      
      override protected function initialize() : void{}
      
      public function updataList() : void{}
   }
}
