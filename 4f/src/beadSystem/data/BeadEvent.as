package beadSystem.data
{
   import ddt.data.goods.ItemTemplateInfo;
   import flash.events.Event;
   
   public class BeadEvent extends Event
   {
      
      public static const EQUIPBEAD:String = "equip";
      
      public static const UNEQUIPBEAD:String = "unequip";
      
      public static const LIGHTBTN:String = "lightButton";
      
      public static const BEADCELLCHANGED:String = "beadCellChanged";
      
      public static const OPENBEADHOLE:String = "openBeadHole";
      
      public static const BEADBAGCELLCHANGED:String = "beadBagCellChanged";
      
      public static const AUTOOPENBEAD:String = "autoOpenBead";
      
      public static const PLAYUPGRADEMC:String = "playUpgradeMC";
      
      public static const SELECT_OPEN_CELL:String = "selectOpenCell";
       
      
      private var _cellID:int;
      
      private var _beadInfo:ItemTemplateInfo;
      
      public function BeadEvent(param1:String, param2:int = -1, param3:ItemTemplateInfo = null, param4:Boolean = false, param5:Boolean = false){super(null,null,null);}
      
      public function get CellId() : int{return 0;}
   }
}
