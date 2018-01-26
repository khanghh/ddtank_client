package starling.scene.hall.player
{
   import ddt.manager.ItemManager;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public class HallPlayerBodyLoader extends HallPlayerBaseLoader
   {
       
      
      private var _content:BitmapData;
      
      private var _color:Array;
      
      private var _style:Array;
      
      private var _sex:Boolean;
      
      private var _mountsType:int;
      
      public function HallPlayerBodyLoader(param1:Array, param2:Array, param3:Boolean, param4:int){super();}
      
      override protected function setLoaderData() : void{}
      
      override protected function drawCharacter() : void{}
      
      override public function get content() : Object{return null;}
      
      override public function dispose() : void{}
   }
}
