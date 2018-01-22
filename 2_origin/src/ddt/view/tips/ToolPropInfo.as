package ddt.view.tips
{
   import ddt.data.goods.ItemTemplateInfo;
   
   public class ToolPropInfo
   {
      
      public static const Psychic:String = "Psychic";
      
      public static const Energy:String = "Energy";
      
      public static const MP:String = "mp";
      
      public static const MAX:String = "max";
       
      
      public var showTurn:Boolean;
      
      public var showCount:Boolean;
      
      public var showThew:Boolean;
      
      public var info:ItemTemplateInfo;
      
      public var count:int;
      
      public var valueType:String = "Energy";
      
      public var value:int;
      
      public var shortcutKey:String;
      
      public function ToolPropInfo()
      {
         super();
      }
   }
}
