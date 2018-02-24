package devilTurn.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import devilTurn.model.DevilTurnGoodsItem;
   
   public class DevilTurnGoodsItemAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:Vector.<DevilTurnGoodsItem>;
      
      public function DevilTurnGoodsItemAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get data() : Vector.<DevilTurnGoodsItem>{return null;}
   }
}
