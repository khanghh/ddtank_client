package beadSystem
{
   import beadSystem.data.BeadEvent;
   import beadSystem.model.BeadModel;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.BeadTemplateManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.AssetModuleLoader;
   import flash.events.EventDispatcher;
   import road7th.comm.PackageIn;
   
   public class beadSystemManager extends EventDispatcher
   {
      
      public static const INFO_VIEW:String = "infoview";
      
      public static const MAIN_VIEW:String = "mainView";
      
      public static const INFO_FRAME:String = "infoframe";
      
      public static const CREATE_COMPLETE:String = "createComplete";
      
      private static var _instance:beadSystemManager;
       
      
      private var _isFirstLoadPackage:Boolean = true;
      
      private var cevent:CEvent;
      
      public function beadSystemManager()
      {
         super();
      }
      
      public static function get Instance() : beadSystemManager
      {
         if(_instance == null)
         {
            _instance = new beadSystemManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      public function initEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(121,3),__onOpenPackage);
         SocketManager.Instance.addEventListener(PkgEvent.format(121,6),__onOpenHole);
      }
      
      private function __onOpenPackage(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg as PackageIn;
         var _loc2_:int = _loc3_.readInt();
         dispatchEvent(new BeadEvent("lightButton",_loc2_));
         BeadModel.beadRequestBtnIndex = _loc2_;
      }
      
      private function __onOpenHole(param1:PkgEvent) : void
      {
         dispatchEvent(new BeadEvent("openBeadHole",0));
      }
      
      public function showFrame(param1:String) : void
      {
         cevent = new CEvent("openview",{"type":param1});
         AssetModuleLoader.addModelLoader("ddtbead",6);
         AssetModuleLoader.addModelLoader("ddtstore",6);
         AssetModuleLoader.startCodeLoader(show);
      }
      
      public function show() : void
      {
         dispatchEvent(cevent);
      }
      
      public function getEquipPlace(param1:InventoryItemInfo) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1.Property1 == "31" && param1.Property2 == "1")
         {
            return 1;
         }
         if(param1.Property1 == "31" && param1.Property2 == "2")
         {
            if(PlayerManager.Instance.Self.BeadBag.getItemAt(2))
            {
               if(PlayerManager.Instance.Self.BeadBag.getItemAt(3))
               {
                  return 2;
               }
               return 3;
            }
            return 2;
         }
         if(param1.Property1 == "31" && param1.Property2 == "3")
         {
            _loc2_ = 5;
            if(PlayerManager.Instance.Self.Grade >= 15)
            {
               _loc2_ = 6;
            }
            if(PlayerManager.Instance.Self.Grade >= 18)
            {
               _loc2_ = 7;
            }
            if(PlayerManager.Instance.Self.Grade >= 21)
            {
               _loc2_ = 8;
            }
            if(PlayerManager.Instance.Self.Grade >= 24)
            {
               _loc2_ = 9;
            }
            if(PlayerManager.Instance.Self.Grade >= 27)
            {
               _loc2_ = 10;
            }
            if(PlayerManager.Instance.Self.Grade >= 30)
            {
               _loc2_ = 11;
            }
            if(PlayerManager.Instance.Self.Grade >= 33)
            {
               _loc2_ = 12;
            }
            _loc3_ = 4;
            while(_loc3_ <= _loc2_)
            {
               if(!PlayerManager.Instance.Self.BeadBag.getItemAt(_loc3_))
               {
                  return _loc3_;
               }
               _loc3_++;
            }
            return 4;
         }
         return -1;
      }
      
      public function getBeadNameTextFormatStyle(param1:int) : String
      {
         var _loc2_:* = null;
         switch(int(param1) - 1)
         {
            case 0:
            case 1:
               _loc2_ = "beadSystem.beadCell.name.tf2";
               break;
            case 2:
            case 3:
               _loc2_ = "beadSystem.beadCell.name.tf3";
               break;
            case 4:
            case 5:
            case 6:
            case 7:
            case 8:
            case 9:
            case 10:
            case 11:
            case 12:
            case 13:
            case 14:
            case 15:
            case 16:
               _loc2_ = "beadSystem.beadCell.name.tf4";
         }
         return _loc2_;
      }
      
      public function judgeLevel(param1:int, param2:int) : Boolean
      {
         switch(int(param2) - 1)
         {
            case 0:
               if(1 <= param1 && param1 <= 4)
               {
                  return true;
               }
               break;
            case 1:
               if(1 <= param1 && param1 <= 8)
               {
                  return true;
               }
               break;
            case 2:
               if(1 <= param1 && param1 <= 12)
               {
                  return true;
               }
               break;
            case 3:
               if(1 <= param1 && param1 <= 16)
               {
                  return true;
               }
               break;
            case 4:
               if(1 <= param1 && param1 <= 19)
               {
                  return true;
               }
               break;
            case 5:
               return true;
         }
         return false;
      }
      
      public function getBeadMcIndex(param1:int) : int
      {
         var _loc2_:int = 0;
         switch(int(param1) - 1)
         {
            case 0:
            case 1:
               _loc2_ = 2;
               break;
            case 2:
            case 3:
               _loc2_ = 3;
               break;
            case 4:
            case 5:
               _loc2_ = 4;
               break;
            case 6:
            case 7:
               _loc2_ = 7;
               break;
            case 8:
            case 9:
               _loc2_ = 8;
               break;
            case 10:
            case 11:
               _loc2_ = 9;
               break;
            case 12:
            case 13:
               _loc2_ = 10;
               break;
            case 14:
            case 15:
               _loc2_ = 11;
               break;
            case 16:
               _loc2_ = 12;
         }
         return _loc2_;
      }
      
      public function getBeadName(param1:InventoryItemInfo) : String
      {
         var _loc2_:String = "";
         if(!param1 || !EquipType.isBead(int(param1.Property1)))
         {
            return "";
         }
         if(param1.Hole2 > 0)
         {
            _loc2_ = BeadTemplateManager.Instance.GetBeadInfobyID(param1.TemplateID).Name + "Lv" + param1.Hole1;
         }
         else
         {
            _loc2_ = BeadTemplateManager.Instance.GetBeadInfobyID(param1.TemplateID).Name + "Lv" + BeadTemplateManager.Instance.GetBeadInfobyID(param1.TemplateID).BaseLevel;
         }
         return _loc2_;
      }
   }
}
