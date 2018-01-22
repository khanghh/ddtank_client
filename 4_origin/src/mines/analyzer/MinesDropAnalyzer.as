package mines.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class MinesDropAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Vector.<DropItemInfo>;
      
      public function MinesDropAnalyzer(param1:Function)
      {
         list = new Vector.<DropItemInfo>();
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc3_:XML = new XML(param1);
         if(_loc3_.@value == "true")
         {
            _loc4_ = _loc3_..Item;
            var _loc7_:int = 0;
            var _loc6_:* = _loc4_;
            for each(var _loc2_ in _loc4_)
            {
               if(_loc2_.@PickAxeLevel == "5")
               {
                  _loc5_ = new DropItemInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc5_,_loc2_);
                  list.push(_loc5_);
               }
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc3_.@message;
            onAnalyzeError();
         }
      }
   }
}
