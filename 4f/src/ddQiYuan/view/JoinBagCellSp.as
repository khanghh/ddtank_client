package ddQiYuan.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import ddQiYuan.DDQiYuanManager;
   import ddQiYuan.model.DDQiYuanModel;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.SocketManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   
   public class JoinBagCellSp extends Sprite implements Disposeable
   {
       
      
      private var _joinBagCell1:BagCell;
      
      private var _model:DDQiYuanModel;
      
      private var _canGainImage:Image;
      
      private var _isPressDown:Boolean;
      
      private var _leftCount:int;
      
      public function JoinBagCellSp(){super();}
      
      private function update(param1:Event) : void{}
      
      private function onMouseHandler(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
