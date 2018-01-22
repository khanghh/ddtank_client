package stock.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import stock.StockMgr;
   import stock.data.StockNewsTemplateData;
   
   public class StockNewsAnalyzer extends DataAnalyzer
   {
       
      
      public function StockNewsAnalyzer(param1:Function = null)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc7_:int = 0;
         var _loc2_:* = null;
         var _loc3_:Dictionary = new Dictionary();
         var _loc4_:XML = new XML(param1);
         var _loc6_:int = _loc4_.Item.length();
         var _loc5_:XMLList = _loc4_.Item;
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc2_ = new StockNewsTemplateData();
            ObjectUtils.copyPorpertiesByXML(_loc2_,_loc5_[_loc7_]);
            _loc3_[_loc2_.NewsId] = _loc2_;
            _loc7_++;
         }
         StockMgr.inst.model.cfgStockNews = _loc3_;
         onAnalyzeComplete();
      }
   }
}
