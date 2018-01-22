package room.model
{
   import bagAndInfo.cell.BagCell;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.LanguageMgr;
   import flash.display.DisplayObject;
   import starling.display.cell.CellContent3D;
   
   public class DeputyWeaponInfo
   {
       
      
      private var _info:ItemTemplateInfo;
      
      public var energy:Number = 110;
      
      public var ballId:int;
      
      public var coolDown:int = 2;
      
      public var weaponType:int = 0;
      
      public var name:String;
      
      public function DeputyWeaponInfo(param1:ItemTemplateInfo)
      {
         name = LanguageMgr.GetTranslation("tank.auctionHouse.view.offhand");
         super();
         _info = param1;
         if(_info)
         {
            energy = Number(_info.Property4);
            ballId = int(_info.Property1);
            coolDown = int(_info.Property6);
            weaponType = int(_info.Property3);
            name = _info.Name;
         }
      }
      
      public function dispose() : void
      {
         _info = null;
      }
      
      public function getDeputyWeaponIcon(param1:int = 0) : DisplayObject
      {
         var _loc2_:BagCell = new BagCell(0,_info);
         if(param1 == 0)
         {
            return _loc2_.getContent();
         }
         if(param1 == 1)
         {
            return _loc2_.getSmallContent();
         }
         return null;
      }
      
      public function getDeputyWeaponIcon3D() : CellContent3D
      {
         var _loc1_:CellContent3D = new CellContent3D(_info);
         _loc1_.loadSync();
         return _loc1_;
      }
      
      public function get isShield() : Boolean
      {
         return _info != null && (_info.TemplateID == 17003 || _info.TemplateID == 17004);
      }
      
      public function get Pic() : String
      {
         return _info.Pic;
      }
      
      public function get TemplateID() : int
      {
         return _info.TemplateID;
      }
      
      public function get Template() : ItemTemplateInfo
      {
         return _info;
      }
   }
}
