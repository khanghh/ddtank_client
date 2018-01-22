package character.action
{
   public class ComplexBitmapAction extends BaseAction
   {
       
      
      private var _assets:Vector.<FrameByFrameItem>;
      
      private var _index:int;
      
      public function ComplexBitmapAction(param1:Vector.<FrameByFrameItem>, param2:String = "", param3:String = "", param4:uint = 0, param5:Boolean = false){super(null,null,null,null);}
      
      override public function get len() : int{return 0;}
      
      override public function reset() : void{}
      
      public function update() : void{}
      
      override public function dispose() : void{}
      
      override public function get isEnd() : Boolean{return false;}
      
      public function get assets() : Vector.<FrameByFrameItem>{return null;}
      
      override public function toXml() : XML{return null;}
   }
}
