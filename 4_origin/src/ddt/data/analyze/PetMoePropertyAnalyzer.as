package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import petsBag.data.PetMoePropertyInfo;
   
   public class PetMoePropertyAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Vector.<PetMoePropertyInfo>;
      
      public function PetMoePropertyAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         _list = new Vector.<PetMoePropertyInfo>();
         var _loc2_:XML = new XML(param1);
         if(_loc2_.@value == "true")
         {
            _loc3_ = _loc2_..Item;
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length())
            {
               _loc4_ = new PetMoePropertyInfo();
               ObjectUtils.copyPorpertiesByXML(_loc4_,_loc3_[_loc5_]);
               _list.push(_loc4_);
               _loc5_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc2_.@message;
            onAnalyzeError();
         }
      }
      
      public function get list() : Vector.<PetMoePropertyInfo>
      {
         return _list;
      }
   }
}
