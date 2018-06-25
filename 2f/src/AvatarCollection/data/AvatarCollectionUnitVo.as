package AvatarCollection.data{   import AvatarCollection.AvatarCollectionManager;   import com.pickgliss.ui.controls.cell.INotSameHeightListCellData;      public class AvatarCollectionUnitVo implements INotSameHeightListCellData   {                   private var _selected:Boolean = false;            private var _id:int;            public var sex:int;            public var name:String;            public var Attack:int;            public var Defence:int;            public var Agility:int;            public var Luck:int;            public var Blood:int;            public var Damage:int;            public var Guard:int;            public var needHonor:int;            public var endTime:Date;            public var Type:int = 1;            public function AvatarCollectionUnitVo() { super(); }
            public function get selected() : Boolean { return false; }
            public function set selected(value:Boolean) : void { }
            public function get id() : int { return 0; }
            public function set id(value:int) : void { }
            public function get totalItemList() : Array { return null; }
            public function get totalActivityItemCount() : int { return 0; }
            public function get canActivityCount() : int { return 0; }
            public function get canBuyCount() : int { return 0; }
            public function getCellHeight() : Number { return 0; }
   }}