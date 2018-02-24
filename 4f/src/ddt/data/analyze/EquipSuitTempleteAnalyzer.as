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
      
      public function EquipSuitTempleteAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get dic() : Dictionary{return null;}
      
      public function get data() : Dictionary{return null;}
   }
}
