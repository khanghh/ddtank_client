package enchant
{
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import enchant.data.EnchantInfo;
   import enchant.data.EnchantModel;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class EnchantManager extends EventDispatcher
   {
      
      private static var _instance:EnchantManager;
       
      
      public var infoVec:Vector.<EnchantInfo>;
      
      public var model:EnchantModel;
      
      public var isUpGrade:Boolean;
      
      public var soulStoneId:int = 11166;
      
      public var soulStoneGoodsId:int = 1116601;
      
      public function EnchantManager(target:IEventDispatcher = null)
      {
         super(target);
         setUp();
      }
      
      public static function get instance() : EnchantManager
      {
         if(!_instance)
         {
            _instance = new EnchantManager();
         }
         return _instance;
      }
      
      public function setupInfoList(analyzer:EnchantInfoAnalyzer) : void
      {
         infoVec = analyzer.list;
      }
      
      private function setUp() : void
      {
         model = new EnchantModel();
         SocketManager.Instance.addEventListener(PkgEvent.format(280),__updateHandler);
      }
      
      public function getEnchantInfoByLevel(level:int) : EnchantInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = infoVec;
         for each(var info in infoVec)
         {
            if(info.Lv == level)
            {
               return info;
            }
         }
         return new EnchantInfo();
      }
      
      protected function __updateHandler(event:PkgEvent) : void
      {
         var exp:int = event.pkg.readInt();
         isUpGrade = event.pkg.readBoolean();
         if(isUpGrade)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("enchant.succes.txt"));
         }
      }
   }
}

class SingleClass
{
    
   
   function SingleClass()
   {
      super();
   }
}
