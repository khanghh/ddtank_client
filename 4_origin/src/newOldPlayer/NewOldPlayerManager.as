package newOldPlayer
{
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ClassUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import ddt.utils.AssetModuleLoader;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class NewOldPlayerManager extends EventDispatcher
   {
      
      private static var _instance:NewOldPlayerManager;
       
      
      private var _changeZoneTime:int;
      
      private var _rechargeMoney:int;
      
      private var _honorLevel:int;
      
      private var _exchangeMoney:int;
      
      private var _questID:Vector.<int>;
      
      public function NewOldPlayerManager()
      {
         _questID = new Vector.<int>();
         super();
      }
      
      public static function get instance() : NewOldPlayerManager
      {
         if(!_instance)
         {
            _instance = new NewOldPlayerManager();
         }
         return _instance;
      }
      
      public function get exchangeMoney() : int
      {
         return _exchangeMoney;
      }
      
      public function set exchangeMoney(value:int) : void
      {
         _exchangeMoney = value;
      }
      
      public function get honorLevel() : int
      {
         return _honorLevel;
      }
      
      public function set honorLevel(value:int) : void
      {
         _honorLevel = value;
      }
      
      public function get rechargeMoney() : int
      {
         return _rechargeMoney;
      }
      
      public function set rechargeMoney(value:int) : void
      {
         _rechargeMoney = value;
      }
      
      public function get changeZoneTime() : int
      {
         return _changeZoneTime;
      }
      
      public function set changeZoneTime(value:int) : void
      {
         _changeZoneTime = value;
      }
      
      public function isQuestFinished(questID:int) : Boolean
      {
         if(_questID.indexOf(questID) >= 0)
         {
            return true;
         }
         return false;
      }
      
      public function stup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(149,16),__newOldPlayerHandler);
      }
      
      private function __newOldPlayerHandler(e:PkgEvent) : void
      {
         HallIconManager.instance.updateSwitchHandler("oldPlayer",true);
         var pkg:PackageIn = e.pkg;
         _changeZoneTime = pkg.readInt();
         _rechargeMoney = pkg.readInt();
         _honorLevel = pkg.readInt();
         _exchangeMoney = pkg.readInt();
         var questID:String = pkg.readUTF();
         _questID = getQuestIDArray(questID);
      }
      
      private function getQuestIDArray(str:String) : Vector.<int>
      {
         var arr:Array = str.split(",");
         var res:Vector.<int> = new Vector.<int>();
         var _loc6_:int = 0;
         var _loc5_:* = arr;
         for each(var num in arr)
         {
            res.push(num);
         }
         return res;
      }
      
      public function init() : void
      {
         HallIconManager.instance.updateSwitchHandler("oldPlayer",true);
      }
      
      public function openView() : void
      {
         AssetModuleLoader.addModelLoader("uicomponent",4);
         AssetModuleLoader.addModelLoader("newOldPlayer",5);
         AssetModuleLoader.startCodeLoader(showFrame);
      }
      
      private function showFrame() : void
      {
         var frame:Sprite = ClassUtils.CreatInstance("newOldPlayer.NewOldPlayerMainFrame") as Sprite;
         LayerManager.Instance.addToLayer(frame,3,true,1);
      }
   }
}
