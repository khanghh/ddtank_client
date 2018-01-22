package magicHouse
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import magicHouse.magicBox.MagicBoxItemInfo;
   
   public class MagicBoxDataAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Vector.<MagicBoxItemInfo>;
      
      public function MagicBoxDataAnalyzer(param1:Function)
      {
         list = new Vector.<MagicBoxItemInfo>();
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc4_:XML = new XML(param1);
         if(_loc4_.@value == "true")
         {
            _loc5_ = _loc4_..Item;
            var _loc7_:int = 0;
            var _loc6_:* = _loc5_;
            for each(var _loc3_ in _loc5_)
            {
               _loc2_ = new MagicBoxItemInfo();
               ObjectUtils.copyPorpertiesByXML(_loc2_,_loc3_);
               list.push(_loc2_);
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc4_.@message;
            onAnalyzeComplete();
         }
      }
   }
}
