package ddt.data
{
   import ddt.data.goods.ItemTemplateInfo;
   
   public class PropInfo
   {
       
      
      private var _template:ItemTemplateInfo;
      
      public var Place:int;
      
      public var Count:int;
      
      public function PropInfo(info:ItemTemplateInfo)
      {
         super();
         _template = info;
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
      
      public function equal(info:PropInfo) : Boolean
      {
         return info.Template == this.Template && info.Place == this.Place;
      }
      
      public function get TemplateID() : int
      {
         return _template.TemplateID;
      }
   }
}
