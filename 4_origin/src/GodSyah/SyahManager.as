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
      
      public function godSyahLoaderCompleted(analyzer:SyahAnalyzer) : void
      {
         var i:int = 0;
         var j:int = 0;
         var arr:Array = analyzer.details;
         if(arr == null)
         {
            return;
         }
         var now:Date = analyzer.nowTime;
         _earlyTime = arr[0][4];
         _enableIndexs = null;
         _enableIndexs = [];
         _cellItemsArray = null;
         _cellItemsArray = [];
         _cellItems = null;
         _cellItems = new Vector.<InventoryItemInfo>();
         _syahItemVec = null;
         _syahItemVec = new Vector.<SyahMode>();
         for(i = 0; i < arr.length; )
         {
            _startTime = arr[i][3];
            _endTime = arr[i][4];
            if(_earlyTime.time > _startTime.time)
            {
               _earlyTime = _startTime;
               _valid = arr[i][1];
               _description = arr[i][2];
            }
            if(now.time >= _startTime.time && now.time < _endTime.time)
            {
               _enableIndexs.push(i);
               _cellItemsArray.push(analyzer.infos[i]);
               for(j = 0; j < analyzer.modes[i].length; )
               {
                  _syahItemVec.push(analyzer.modes[i][j]);
                  j++;
               }
            }
            i++;
         }
         if(_enableIndexs.length > 0)
         {
            setup();
         }
      }
      
      public function get cellItems() : Vector.<InventoryItemInfo>
      {
         var i:int = 0;
         var j:int = 0;
         var cellItems:Vector.<InventoryItemInfo> = new Vector.<InventoryItemInfo>();
         for(i = 0; i < _cellItemsArray.length; )
         {
            for(j = 0; j < _cellItemsArray[i].length; )
            {
               cellItems.push(_cellItemsArray[i][j]);
               j++;
            }
            i++;
         }
         return cellItems;
      }
      
      public function getSyahModeByInfo(info:ItemTemplateInfo) : SyahMode
      {
         var i:int = 0;
         for(i = 0; i < _syahItemVec.length; )
         {
            if(info is InventoryItemInfo)
            {
               if(_syahItemVec[i].level == -1 && _syahItemVec[i].syahID == info.TemplateID)
               {
                  return _syahItemVec[i];
               }
               if(_syahItemVec[i].syahID == info.TemplateID && _syahItemVec[i].isGold == (info as InventoryItemInfo).isGold && _syahItemVec[i].level == (info as InventoryItemInfo).StrengthenLevel)
               {
                  return _syahItemVec[i];
               }
            }
            else if(_syahItemVec[i].syahID == info.TemplateID)
            {
               return _syahItemVec[i];
            }
            i++;
         }
         return null;
      }
      
      public function setModeValid(info:Object) : Boolean
      {
         var now:Date = TimeManager.Instance.serverDate;
         var valid:Number = _endTime.time - now.time;
         if(info is InventoryItemInfo)
         {
            if(info.ValidDate == 0)
            {
               return true;
            }
            if(info.getRemainDate() * 24 * 60 * 60 * 1000 >= valid)
            {
               return true;
            }
         }
         return false;
      }
      
      public function selectFromBagAndInfo() : void
      {
         var i:int = 0;
         var j:int = 0;
         var now:Date = TimeManager.Instance.serverDate;
         var valid:Number = _endTime.time - now.time;
         var arr:Array = PlayerManager.Instance.Self.Bag.items.list;
         for(i = 0; i < _syahItemVec.length; )
         {
            _syahItemVec[i].isHold = false;
            _syahItemVec[i].isValid = false;
            for(j = 0; j < arr.length; )
            {
               if(_syahItemVec[i].level == -1 && _syahItemVec[i].syahID == arr[j].TemplateID)
               {
                  _syahItemVec[i].isHold = true;
                  if(arr[j].ValidDate == 0)
                  {
                     _syahItemVec[i].isValid = true;
                  }
                  else if(arr[j].getRemainDate() * 24 * 60 * 60 * 1000 >= valid)
                  {
                     _syahItemVec[i].isValid = true;
                  }
               }
               else if(_syahItemVec[i].syahID == arr[j].TemplateID && _syahItemVec[i].isGold == arr[j].isGold && _syahItemVec[i].level == arr[j].StrengthenLevel)
               {
                  _syahItemVec[i].isHold = true;
                  if(arr[j].ValidDate == 0)
                  {
                     _syahItemVec[i].isValid = true;
                  }
                  else if(arr[j].getRemainDate() * 24 * 60 * 60 * 1000 >= valid)
                  {
                     _syahItemVec[i].isValid = true;
                  }
               }
               j++;
            }
            i++;
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
      
      public function set isOpen(value:Boolean) : void
      {
         _isOpen = value;
      }
      
      public function get login() : Boolean
      {
         return _login;
      }
      
      public function set login(value:Boolean) : void
      {
         _login = value;
      }
      
      public function get inView() : Boolean
      {
         return _inView;
      }
      
      public function set inView(value:Boolean) : void
      {
         _inView = value;
      }
   }
}
