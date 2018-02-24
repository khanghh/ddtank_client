package farm.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import farm.view.compose.vo.FoodComposeListTemplateInfo;
   import flash.utils.Dictionary;
   
   public class FoodComposeListAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Dictionary;
      
      private var _listDetail:Vector.<FoodComposeListTemplateInfo>;
      
      public function FoodComposeListAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
   }
}
