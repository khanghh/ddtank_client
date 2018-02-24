package devilTurn.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import devilTurn.model.DevilTurnGoodsItem;
   
   public class DevilTurnGoodsItemAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:Vector.<DevilTurnGoodsItem>;
      
      public function DevilTurnGoodsItemAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc3_:XML = new XML(param1);
         _data = new Vector.<DevilTurnGoodsItem>();
         if(_loc3_.@value == "true")
         {
            _loc4_ = _loc3_..Item;
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length())
            {
               _loc2_ = new DevilTurnGoodsItem();
               ObjectUtils.copyPorpertiesByXML(_loc2_,_loc4_[_loc5_]);
               _data.push(_loc2_);
               _loc5_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc3_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
      
      public function get data() : Vector.<DevilTurnGoodsItem>
      {
         return _data;
      }
   }
}
