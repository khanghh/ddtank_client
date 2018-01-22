package character.action
{
   public class SimpleFrameAction extends BaseAction
   {
       
      
      private var _frames:Vector.<int>;
      
      public function SimpleFrameAction(param1:Vector.<int>, param2:String = "", param3:String = "", param4:uint = 0, param5:Boolean = false){super(null,null,null,null);}
      
      public function set frames(param1:Vector.<int>) : void{}
      
      public function get frames() : Vector.<int>{return null;}
      
      override public function toXml() : XML{return null;}
   }
}
