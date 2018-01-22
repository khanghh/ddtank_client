package particleSystem
{
   import com.pickgliss.loader.DataAnalyzer;
   import flash.utils.Dictionary;
   
   public class EmitterInfoAnalyzer extends DataAnalyzer
   {
       
      
      public var emitters:Dictionary;
      
      public function EmitterInfoAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc5_:XML = new XML(param1);
         emitters = new Dictionary();
         var _loc4_:XMLList = _loc5_..emitter;
         var _loc8_:int = 0;
         var _loc7_:* = _loc4_;
         for each(var _loc6_ in _loc4_)
         {
            _loc2_ = new EmitterInfo();
            _loc2_.id = _loc6_.@id;
            _loc2_.name = _loc6_.@name;
            _loc3_ = String(_loc6_.@particles).split(",");
            _loc2_.particleIds = _loc3_;
            emitters[_loc2_.id] = _loc2_;
         }
         onAnalyzeComplete();
      }
   }
}
