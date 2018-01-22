package playerDress
{
   import ddt.CoreManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import flash.events.Event;
   import playerDress.components.DressModel;
   import playerDress.components.DressUtils;
   import playerDress.data.DressVo;
   import playerDress.event.PlayerDressEvent;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   
   public class PlayerDressManager extends CoreManager
   {
      
      public static const CURRENTMODEL_SET:String = "currentmodel_set";
      
      private static var _instance:PlayerDressManager;
       
      
      public var currentIndex:int;
      
      public var modelArr:Array;
      
      public var currentModel:DressModel;
      
      public var currentModelNum:int = 3;
      
      public var additionModel:Array;
      
      private var _viewTypeArr:Array;
      
      public function PlayerDressManager()
      {
         super();
         _viewTypeArr = [];
         modelArr = [];
      }
      
      public static function get instance() : PlayerDressManager
      {
         if(!_instance)
         {
            _instance = new PlayerDressManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(237,1),setDressModelArr);
         SocketManager.Instance.addEventListener(PkgEvent.format(237,2),setCurrentModel);
         additionModel = ServerConfigManager.instance.addPlayerDressModel;
      }
      
      protected function setCurrentModel(param1:PkgEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc5_:PackageIn = param1.pkg;
         PlayerDressManager.instance.currentIndex = _loc5_.readInt();
         if(currentModelNum != 6 && currentIndex == currentModelNum)
         {
            currentIndex = currentIndex - 1;
         }
         if(PlayerDressManager.instance.currentIndex == -1)
         {
            SocketManager.Instance.out.setCurrentModel(0);
            _loc3_ = PlayerManager.Instance.Self.Bag.items;
            _loc2_ = [];
            _loc6_ = 0;
            while(_loc6_ <= 8 - 1)
            {
               _loc4_ = _loc3_[DressUtils.getBagItems(_loc6_)];
               if(_loc4_)
               {
                  _loc2_.push(_loc4_.Place);
               }
               _loc6_++;
            }
            SocketManager.Instance.out.saveDressModel(0,_loc2_);
         }
         else
         {
            SocketManager.Instance.dispatchEvent(new Event("currentmodel_set"));
         }
      }
      
      protected function setDressModelArr(param1:PkgEvent) : void
      {
         var _loc9_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:* = null;
         var _loc5_:int = 0;
         var _loc8_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         currentModelNum = _loc4_.readInt();
         var _loc7_:int = _loc4_.readInt();
         _loc9_ = 0;
         while(_loc9_ <= _loc7_ - 1)
         {
            _loc2_ = _loc4_.readInt();
            _loc3_ = _loc4_.readInt();
            _loc6_ = [];
            _loc5_ = 0;
            while(_loc5_ <= _loc3_ - 1)
            {
               _loc8_ = new DressVo();
               _loc8_.itemId = _loc4_.readInt();
               _loc8_.templateId = _loc4_.readInt();
               _loc6_.push(_loc8_);
               _loc5_++;
            }
            modelArr[_loc2_] = _loc6_;
            _loc9_++;
         }
         dispatchEvent(new PlayerDressEvent("setBtnStatus"));
         PlayerDressManager.instance.modelArr = modelArr;
      }
      
      public function showView(param1:int) : void
      {
         if(_viewTypeArr.indexOf(param1) == -1)
         {
            _viewTypeArr.push(param1);
         }
         show();
      }
      
      public function disposeView(param1:int) : void
      {
         var _loc2_:PlayerDressEvent = new PlayerDressEvent("playerDressDispose");
         _loc2_.info = param1;
         dispatchEvent(_loc2_);
      }
      
      override protected function start() : void
      {
         var _loc1_:* = null;
         while(_viewTypeArr.length > 0)
         {
            _loc1_ = new PlayerDressEvent("playerDressOpen");
            _loc1_.info = _viewTypeArr.shift();
            dispatchEvent(_loc1_);
         }
      }
   }
}
