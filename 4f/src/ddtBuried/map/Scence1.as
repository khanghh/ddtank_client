package ddtBuried.map
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddtBuried.BuriedControl;
   import ddtBuried.BuriedManager;
   import ddtBuried.data.MapItemData;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Scence1 extends MovieClip implements Disposeable
   {
       
      
      private var _content:Sprite;
      
      private var _mapArray:Array;
      
      private var _map:Maps;
      
      private var standArray:Array;
      
      public function Scence1(param1:String, param2:int, param3:int){super();}
      
      private function initView(param1:String, param2:int, param3:int) : void{}
      
      private function initMapItem() : void{}
      
      public function getRoadPoint() : Point{return null;}
      
      public function updateRoadPoint(param1:int = 0) : void{}
      
      private function creatIcon(param1:int) : Sprite{return null;}
      
      public function selfFindPath(param1:int, param2:int) : void{}
      
      public function dispose() : void{}
   }
}
