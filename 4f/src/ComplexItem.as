package
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ComplexItem extends BitmapRendItem
   {
       
      
      protected var _items:Vector.<BitmapRendItem>;
      
      private var item:BitmapRendItem;
      
      private var tempcopyInfo:Array;
      
      public function ComplexItem(param1:Number, param2:Number, param3:String = "original", param4:String = "auto", param5:Boolean = false){super(null,null,null,null,null);}
      
      public function addItem(param1:FrameByFrameItem) : void{}
      
      public function removeItem(param1:FrameByFrameItem) : void{}
      
      override public function set scaleX(param1:Number) : void{}
      
      override protected function update() : void{}
      
      override function get copyInfo() : Array{return null;}
      
      override public function dispose() : void{}
      
      override public function get typeToString() : String{return null;}
      
      override public function toXml() : XML{return null;}
   }
}
