package ddt.data
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.utils.Dictionary;
   
   public class BeadModel
   {
      
      private static var _ins:BeadModel;
       
      
      private var _beadDic:Dictionary;
      
      public function BeadModel()
      {
         _beadDic = new Dictionary();
         super();
      }
      
      public static function getInstance() : BeadModel
      {
         if(_ins == null)
         {
            _ins = ComponentFactory.Instance.creatCustomObject("BeadModel");
         }
         return _ins;
      }
      
      public function set beads(val:String) : void
      {
         var arr:Array = val.split(",");
         var _loc5_:int = 0;
         var _loc4_:* = arr;
         for each(var id in arr)
         {
            _beadDic[id] = true;
         }
      }
      
      public function isBeadFromSmelt(id:int) : Boolean
      {
         return _beadDic[id] == true;
      }
      
      public function isAttackBead(item:ItemTemplateInfo) : Boolean
      {
         return isBeadFromSmelt(item.TemplateID) && item.Property2 == "1";
      }
      
      public function isDefenceBead(item:ItemTemplateInfo) : Boolean
      {
         return isBeadFromSmelt(item.TemplateID) && item.Property2 == "2";
      }
      
      public function isAttributeBead(item:ItemTemplateInfo) : Boolean
      {
         return isBeadFromSmelt(item.TemplateID) && item.Property2 == "3";
      }
   }
}
