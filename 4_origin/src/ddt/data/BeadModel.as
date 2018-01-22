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
      
      public function set beads(param1:String) : void
      {
         var _loc3_:Array = param1.split(",");
         var _loc5_:int = 0;
         var _loc4_:* = _loc3_;
         for each(var _loc2_ in _loc3_)
         {
            _beadDic[_loc2_] = true;
         }
      }
      
      public function isBeadFromSmelt(param1:int) : Boolean
      {
         return _beadDic[param1] == true;
      }
      
      public function isAttackBead(param1:ItemTemplateInfo) : Boolean
      {
         return isBeadFromSmelt(param1.TemplateID) && param1.Property2 == "1";
      }
      
      public function isDefenceBead(param1:ItemTemplateInfo) : Boolean
      {
         return isBeadFromSmelt(param1.TemplateID) && param1.Property2 == "2";
      }
      
      public function isAttributeBead(param1:ItemTemplateInfo) : Boolean
      {
         return isBeadFromSmelt(param1.TemplateID) && param1.Property2 == "3";
      }
   }
}
