package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.EquipSuitTemplateInfo;
   import ddt.data.goods.SuitTemplateInfo;
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   
   public class EquipSuitTempleteAnalyzer extends DataAnalyzer
   {
       
      
      private var _dic:Dictionary;
      
      private var _data:Dictionary;
      
      public function EquipSuitTempleteAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc2_:* = null;
         _dic = new Dictionary();
         _data = new Dictionary();
         var _loc3_:XML = new XML(param1);
         if(_loc3_.@value == "true")
         {
            _loc5_ = _loc3_..item;
            _loc4_ = describeType(new SuitTemplateInfo());
            _loc7_ = 0;
            while(_loc7_ < _loc5_.length())
            {
               _loc6_ = new EquipSuitTemplateInfo();
               ObjectUtils.copyPorpertiesByXML(_loc6_,_loc5_[_loc7_]);
               if(_dic[_loc6_.ID])
               {
                  _loc2_ = _dic[_loc6_.ID];
               }
               else
               {
                  _loc2_ = [];
                  _dic[_loc6_.ID] = _loc2_;
               }
               _loc2_.push(_loc6_);
               _data[_loc6_.PartName] = _loc6_;
               _loc7_++;
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
      
      public function get dic() : Dictionary
      {
         return _dic;
      }
      
      public function get data() : Dictionary
      {
         return _data;
      }
   }
}
