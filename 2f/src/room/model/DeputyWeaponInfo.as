package room.model{   import bagAndInfo.cell.BagCell;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.LanguageMgr;   import flash.display.DisplayObject;   import starling.display.cell.CellContent3D;      public class DeputyWeaponInfo   {                   private var _info:ItemTemplateInfo;            public var energy:Number = 110;            public var ballId:int;            public var coolDown:int = 2;            public var weaponType:int = 0;            public var name:String;            public function DeputyWeaponInfo(itemInfo:ItemTemplateInfo) { super(); }
            public function dispose() : void { }
            public function getDeputyWeaponIcon(type:int = 0) : DisplayObject { return null; }
            public function getDeputyWeaponIcon3D() : CellContent3D { return null; }
            public function get isShield() : Boolean { return false; }
            public function get Pic() : String { return null; }
            public function get TemplateID() : int { return 0; }
            public function get Template() : ItemTemplateInfo { return null; }
   }}