package store.view.strength.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import store.view.strength.vo.ItemStrengthenGoodsInfo;
   
   public class ItemStrengthenGoodsInfoAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Dictionary;
      
      private var _xml:XML;
      
      public function ItemStrengthenGoodsInfoAnalyzer(param1:Function)
      {
         list = new Dictionary();
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         _xml = new XML(param1);
         list = new Dictionary();
         var _loc3_:XMLList = _xml..Item;
         if(_xml.@value == "true")
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length())
            {
               _loc2_ = new ItemStrengthenGoodsInfo();
               ObjectUtils.copyPorpertiesByXML(_loc2_,_loc3_[_loc4_]);
               list[_loc2_.CurrentEquip + "," + _loc2_.Level] = _loc2_;
               _loc4_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _xml.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
