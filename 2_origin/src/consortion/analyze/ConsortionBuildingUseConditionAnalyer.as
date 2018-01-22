package consortion.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.ConsortiaAssetLevelOffer;
   
   public class ConsortionBuildingUseConditionAnalyer extends DataAnalyzer
   {
       
      
      public var useConditionList:Vector.<ConsortiaAssetLevelOffer>;
      
      public function ConsortionBuildingUseConditionAnalyer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         useConditionList = new Vector.<ConsortiaAssetLevelOffer>();
         var _loc2_:XML = new XML(param1);
         if(_loc2_.@value == "true")
         {
            _loc4_ = XML(_loc2_)..Item;
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length())
            {
               _loc3_ = new ConsortiaAssetLevelOffer();
               ObjectUtils.copyPorpertiesByXML(_loc3_,_loc4_[_loc5_]);
               useConditionList.push(_loc3_);
               _loc5_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc2_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
