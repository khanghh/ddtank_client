package GodSyah
{
   import ddt.CoreManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.Event;
   import hallIcon.HallIconManager;
   
   public class SyahManager extends CoreManager
   {
      
      public static const SHOWMAINVIEW:String = "showMainView";
      
      public static const HIDEMAINVIEW:String = "hideMainView";
      
      private static var _syahManager:SyahManager;
       
      
      public const SYAHVIEW:String = "syahview";
      
      public const BAGANDOTHERS:String = "bagandothers";
      
      public const OTHERS:String = "others";
      
      public var totalDamage:int;
      
      public var totalArmor:int;
      
      private var _isOpen:Boolean = false;
      
      private var _syahItemVec:Vector.<SyahMode>;
      
      private var _valid:String;
      
      private var _description:String;
      
      private var _startTime:Date;
      
      private var _endTime:Date;
      
      private var _enableIndexs:Array;
      
      private var _earlyTime:Date;
      
      private var _isStart:Boolean;
      
      private var _login:Boolean;
      
      private var _cellItems:Vector.<InventoryItemInfo>;
      
      private var _cellItemsArray:Array;
      
      private var _inView:Boolean;
      
      public function SyahManager()
      {
         super();
      }
      
      public static function get Instance() : SyahManager
      {
         if(_syahManager == null)
         {
            _syahManager = new SyahManager();
         }
         return _syahManager;
      }
      
      override protected function start() : void
      {
         SoundManager.instance.play("008");
         _syahLoad();
      }
      
      private function _syahLoad() : void
      {
         new HelperUIModuleLoad().loadUIModule(["wonderfulactivity"],onLoaded);
      }
      
      private function onLoaded() : void
      {
         dispatchEvent(new Event("showMainView"));
      }
      
      public function godSyahLoaderCompleted(param1:SyahAnalyzer) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:Array = param1.details;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:Date = param1.nowTime;
         _earlyTime = _loc3_[0][4];
         _enableIndexs = null;
         _enableIndexs = [];
         _cellItemsArray = null;
         _cellItemsArray = [];
         _cellItems = null;
         _cellItems = new Vector.<InventoryItemInfo>();
         _syahItemVec = null;
         _syahItemVec = new Vector.<SyahMode>();
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _startTime = _loc3_[_loc5_][3];
            _endTime = _loc3_[_loc5_][4];
            if(_earlyTime.time > _startTime.time)
            {
               _earlyTime = _startTime;
               _valid = _loc3_[_loc5_][1];
               _description = _loc3_[_loc5_][2];
            }
            if(_loc2_.time >= _startTime.time && _loc2_.time < _endTime.time)
            {
               _enableIndexs.push(_loc5_);
               _cellItemsArray.push(param1.infos[_loc5_]);
               _loc4_ = 0;
               while(_loc4_ < param1.modes[_loc5_].length)
               {
                  _syahItemVec.push(param1.modes[_loc5_][_loc4_]);
                  _loc4_++;
               }
            }
            _loc5_++;
         }
         if(_enableIndexs.length > 0)
         {
            setup();
         }
      }
      
      public function get cellItems() : Vector.<InventoryItemInfo>
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:Vector.<InventoryItemInfo> = new Vector.<InventoryItemInfo>();
         _loc3_ = 0;
         while(_loc3_ < _cellItemsArray.length)
         {
            _loc2_ = 0;
            while(_loc2_ < _cellItemsArray[_loc3_].length)
            {
               _loc1_.push(_cellItemsArray[_loc3_][_loc2_]);
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function getSyahModeByInfo(param1:ItemTemplateInfo) : SyahMode
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _syahItemVec.length)
         {
            if(param1 is InventoryItemInfo)
            {
               if(_syahItemVec[_loc2_].level == -1 && _syahItemVec[_loc2_].syahID == param1.TemplateID)
               {
                  return _syahItemVec[_loc2_];
               }
               if(_syahItemVec[_loc2_].syahID == param1.TemplateID && _syahItemVec[_loc2_].isGold == (param1 as InventoryItemInfo).isGold && _syahItemVec[_loc2_].level == (param1 as InventoryItemInfo).StrengthenLevel)
               {
                  return _syahItemVec[_loc2_];
               }
            }
            else if(_syahItemVec[_loc2_].syahID == param1.TemplateID)
            {
               return _syahItemVec[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function setModeValid(param1:Object) : Boolean
      {
         var _loc3_:Date = TimeManager.Instance.serverDate;
         var _loc2_:Number = _endTime.time - _loc3_.time;
         if(param1 is InventoryItemInfo)
         {
            if(param1.ValidDate == 0)
            {
               return true;
            }
            if(param1.getRemainDate() * 24 * 60 * 60 * 1000 >= _loc2_)
            {
               return true;
            }
         }
         return false;
      }
      
      public function selectFromBagAndInfo() : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:Date = TimeManager.Instance.serverDate;
         var _loc1_:Number = _endTime.time - _loc3_.time;
         var _loc2_:Array = PlayerManager.Instance.Self.Bag.items.list;
         _loc5_ = 0;
         while(_loc5_ < _syahItemVec.length)
         {
            _syahItemVec[_loc5_].isHold = false;
            _syahItemVec[_loc5_].isValid = false;
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               if(_syahItemVec[_loc5_].level == -1 && _syahItemVec[_loc5_].syahID == _loc2_[_loc4_].TemplateID)
               {
                  _syahItemVec[_loc5_].isHold = true;
                  if(_loc2_[_loc4_].ValidDate == 0)
                  {
                     _syahItemVec[_loc5_].isValid = true;
                  }
                  else if(_loc2_[_loc4_].getRemainDate() * 24 * 60 * 60 * 1000 >= _loc1_)
                  {
                     _syahItemVec[_loc5_].isValid = true;
                  }
               }
               else if(_syahItemVec[_loc5_].syahID == _loc2_[_loc4_].TemplateID && _syahItemVec[_loc5_].isGold == _loc2_[_loc4_].isGold && _syahItemVec[_loc5_].level == _loc2_[_loc4_].StrengthenLevel)
               {
                  _syahItemVec[_loc5_].isHold = true;
                  if(_loc2_[_loc4_].ValidDate == 0)
                  {
                     _syahItemVec[_loc5_].isValid = true;
                  }
                  else if(_loc2_[_loc4_].getRemainDate() * 24 * 60 * 60 * 1000 >= _loc1_)
                  {
                     _syahItemVec[_loc5_].isValid = true;
                  }
               }
               _loc4_++;
            }
            _loc5_++;
         }
      }
      
      private function setup() : void
      {
         _isOpen = true;
         showIcon();
      }
      
      public function stopSyah() : void
      {
         HallIconManager.instance.updateSwitchHandler("syah",false);
      }
      
      public function showIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("syah",true);
      }
      
      public function get syahItemVec() : Vector.<SyahMode>
      {
         return _syahItemVec;
      }
      
      public function get valid() : String
      {
         return _valid;
      }
      
      public function get description() : String
      {
         return _description;
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         _isOpen = param1;
      }
      
      public function get login() : Boolean
      {
         return _login;
      }
      
      public function set login(param1:Boolean) : void
      {
         _login = param1;
      }
      
      public function get inView() : Boolean
      {
         return _inView;
      }
      
      public function set inView(param1:Boolean) : void
      {
         _inView = param1;
      }
   }
}
