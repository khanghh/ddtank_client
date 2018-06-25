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
      
      protected function setCurrentModel(event:PkgEvent) : void
      {
         var items:* = null;
         var arr:* = null;
         var i:int = 0;
         var item:* = null;
         var pkg:PackageIn = event.pkg;
         PlayerDressManager.instance.currentIndex = pkg.readInt();
         if(currentModelNum != 6 && currentIndex == currentModelNum)
         {
            currentIndex = currentIndex - 1;
         }
         if(PlayerDressManager.instance.currentIndex == -1)
         {
            SocketManager.Instance.out.setCurrentModel(0);
            items = PlayerManager.Instance.Self.Bag.items;
            arr = [];
            for(i = 0; i <= 8 - 1; )
            {
               item = items[DressUtils.getBagItems(i)];
               if(item)
               {
                  arr.push(item.Place);
               }
               i++;
            }
            SocketManager.Instance.out.saveDressModel(0,arr);
         }
         else
         {
            SocketManager.Instance.dispatchEvent(new Event("currentmodel_set"));
         }
      }
      
      protected function setDressModelArr(event:PkgEvent) : void
      {
         var i:int = 0;
         var modelId:int = 0;
         var dressCount:int = 0;
         var dressArr:* = null;
         var j:int = 0;
         var vo:* = null;
         var pkg:PackageIn = event.pkg;
         currentModelNum = pkg.readInt();
         var modelCount:int = pkg.readInt();
         for(i = 0; i <= modelCount - 1; )
         {
            modelId = pkg.readInt();
            dressCount = pkg.readInt();
            dressArr = [];
            for(j = 0; j <= dressCount - 1; )
            {
               vo = new DressVo();
               vo.itemId = pkg.readInt();
               vo.templateId = pkg.readInt();
               dressArr.push(vo);
               j++;
            }
            modelArr[modelId] = dressArr;
            i++;
         }
         dispatchEvent(new PlayerDressEvent("setBtnStatus"));
         PlayerDressManager.instance.modelArr = modelArr;
      }
      
      public function showView(type:int) : void
      {
         if(_viewTypeArr.indexOf(type) == -1)
         {
            _viewTypeArr.push(type);
         }
         show();
      }
      
      public function disposeView(type:int) : void
      {
         var event:PlayerDressEvent = new PlayerDressEvent("playerDressDispose");
         event.info = type;
         dispatchEvent(event);
      }
      
      override protected function start() : void
      {
         var event:* = null;
         while(_viewTypeArr.length > 0)
         {
            event = new PlayerDressEvent("playerDressOpen");
            event.info = _viewTypeArr.shift();
            dispatchEvent(event);
         }
      }
   }
}
