package character.action
{
   public class SimpleFrameAction extends BaseAction
   {
       
      
      private var _frames:Vector.<int>;
      
      public function SimpleFrameAction(param1:Vector.<int>, param2:String = "", param3:String = "", param4:uint = 0, param5:Boolean = false)
      {
         this._frames = param1;
         _len = this._frames.length;
         super(param2,param3,param4,param5);
         _type = BaseAction.SIMPLE_ACTION;
      }
      
      public function set frames(param1:Vector.<int>) : void
      {
         this._frames = param1;
      }
      
      public function get frames() : Vector.<int>
      {
         return this._frames.concat();
      }
      
      override public function toXml() : XML
      {
         var _loc1_:XML = super.toXml();
         _loc1_.@frames = this._frames.toString();
         return _loc1_;
      }
   }
}
