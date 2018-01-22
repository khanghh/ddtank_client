package Indiana.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class IndianaTitleCellView extends Sprite implements Disposeable
   {
       
      
      private var group:Vector.<IndianaTitleCell>;
      
      private var _currentCell:IndianaTitleCell;
      
      public var callBack:Function;
      
      private var _bg:Bitmap;
      
      private var _cells:Array;
      
      public function IndianaTitleCellView(){super();}
      
      private function initCell() : void{}
      
      private function clearCells() : void{}
      
      private function sortCell() : void{}
      
      private function sortPos(param1:Point, param2:Point) : Number{return 0;}
      
      public function setInfos(param1:Array) : void{}
      
      public function get currentCell() : IndianaTitleCell{return null;}
      
      public function get leftCell() : IndianaTitleCell{return null;}
      
      public function get rightCell() : IndianaTitleCell{return null;}
      
      private function __cellClickHandler(param1:MouseEvent) : void{}
      
      public function updateCurrentCell(param1:int) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
