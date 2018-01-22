package tofflist.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import flash.display.Sprite;
   import flash.geom.Point;
   import tofflist.TofflistEvent;
   import tofflist.TofflistModel;
   
   public class TofflistOrderList extends Sprite implements Disposeable
   {
       
      
      private var _currenItem:TofflistOrderItem;
      
      private var _items:Vector.<TofflistOrderItem>;
      
      private var _list:VBox;
      
      public function TofflistOrderList(){super();}
      
      public function dispose() : void{}
      
      public function items(param1:Array, param2:int = 1) : void{}
      
      protected function __itemChange2(param1:TofflistEvent) : void{}
      
      public function showHline(param1:Vector.<Point>) : void{}
      
      private function __itemChange(param1:TofflistEvent) : void{}
      
      private function addEvent() : void{}
      
      public function clearList() : void{}
      
      private function init() : void{}
   }
}
