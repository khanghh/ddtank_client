package ddt.data{   import com.pickgliss.ui.ComponentFactory;   import ddt.data.goods.ItemTemplateInfo;   import flash.utils.Dictionary;      public class BeadModel   {            private static var _ins:BeadModel;                   private var _beadDic:Dictionary;            public function BeadModel() { super(); }
            public static function getInstance() : BeadModel { return null; }
            public function set beads(val:String) : void { }
            public function isBeadFromSmelt(id:int) : Boolean { return false; }
            public function isAttackBead(item:ItemTemplateInfo) : Boolean { return false; }
            public function isDefenceBead(item:ItemTemplateInfo) : Boolean { return false; }
            public function isAttributeBead(item:ItemTemplateInfo) : Boolean { return false; }
   }}