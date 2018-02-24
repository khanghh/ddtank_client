package ddt.data
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.utils.Dictionary;
   
   public class BeadModel
   {
      
      private static var _ins:BeadModel;
       
      
      private var _beadDic:Dictionary;
      
      public function BeadModel(){super();}
      
      public static function getInstance() : BeadModel{return null;}
      
      public function set beads(param1:String) : void{}
      
      public function isBeadFromSmelt(param1:int) : Boolean{return false;}
      
      public function isAttackBead(param1:ItemTemplateInfo) : Boolean{return false;}
      
      public function isDefenceBead(param1:ItemTemplateInfo) : Boolean{return false;}
      
      public function isAttributeBead(param1:ItemTemplateInfo) : Boolean{return false;}
   }
}
