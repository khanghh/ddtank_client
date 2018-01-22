package treasureHunting.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.RouletteManager;
   import ddt.view.caddyII.CaddyEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import treasureHunting.items.LuckRankItem;
   
   public class TreasureRankView extends Sprite implements Disposeable
   {
       
      
      private var _rankBG:Bitmap;
      
      private var _itemBGDeep:Bitmap;
      
      private var _itemBGLighter:Bitmap;
      
      private var _ranklist:VBox;
      
      private var _itemList:Vector.<LuckRankItem>;
      
      private var _dataList:Vector.<Object>;
      
      public function TreasureRankView(){super();}
      
      private function initView() : void{}
      
      protected function onItemClick(param1:MouseEvent) : void{}
      
      private function initEvent() : void{}
      
      protected function __getLuckRank(param1:CaddyEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
