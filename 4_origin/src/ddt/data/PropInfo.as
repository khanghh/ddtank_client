package ddt.data
{
   import ddt.data.goods.ItemTemplateInfo;
   
   public class PropInfo
   {
       
      
      private var _template:ItemTemplateInfo;
      
      public var Place:int;
      
      public var Count:int;
      
      public function PropInfo(param1:ItemTemplateInfo)
      {
         super();
         _template = param1;
      }
      
      public function get Template() : ItemTemplateInfo
      {
         return _template;
      }
      
      public function get needEnergy() : Number
      {
         return Number(_template.Property4);
      }
      
      public function get needPsychic() : int
      {
         return int(_template.Property7);
      }
      
      public function equal(param1:PropInfo) : Boolean
      {
         return param1.Template == this.Template && param1.Place == this.Place;
      }
      
      public function get TemplateID() : int
      {
         return _template.TemplateID;
      }
   }
}
