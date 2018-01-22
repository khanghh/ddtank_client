package
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import mx.events.PropertyChangeEvent;
   
   public class CrossFrameItem extends FrameByFrameItem
   {
       
      
      protected var _frames:Vector.<int>;
      
      public function CrossFrameItem(param1:Number, param2:Number, param3:BitmapData, param4:Vector.<int> = null, param5:String = "original", param6:Boolean = false){super(null,null,null,null,null);}
      
      override function get copyInfo() : Array{return null;}
      
      protected function invalid(param1:Vector.<int>) : void{}
      
      public function set _896505829source(param1:BitmapData) : void{}
      
      override protected function update() : void{}
      
      public function get frames() : Vector.<int>{return null;}
      
      private function set _1266514778frames(param1:Vector.<int>) : void{}
      
      override public function get typeToString() : String{return null;}
      
      override public function toXml() : XML{return null;}
      
      [Bindable(event="propertyChange")]
      override public function set source(param1:BitmapData) : void{}
      
      [Bindable(event="propertyChange")]
      public function set frames(param1:Vector.<int>) : void{}
   }
}
