package bagAndInfo.ddtKingGrade
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.CoreManager;
   import ddt.loader.LoaderCreate;
   import ddt.utils.HelperDataModuleLoad;
   import ddt.utils.HelperUIModuleLoad;
   import road7th.data.DictionaryData;
   
   public class DDTKingGradeManager extends CoreManager
   {
      
      private static var _instance:DDTKingGradeManager;
       
      
      private var _data:DictionaryData;
      
      public var isOpen:Boolean;
      
      public function DDTKingGradeManager()
      {
         super();
      }
      
      public static function get Instance() : DDTKingGradeManager
      {
         if(_instance == null)
         {
            _instance = new DDTKingGradeManager();
         }
         return _instance;
      }
      
      override protected function start() : void
      {
         new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.createDDTKingGradeTemplate()],function():void
         {
            new HelperUIModuleLoad().loadUIModule(["ddtkinggrade"],onComplete);
         });
      }
      
      private function onComplete() : void
      {
         var _loc1_:* = undefined;
         if(isOpen == false)
         {
            isOpen = true;
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ddtKingGrade.mainView");
            _loc1_.show();
         }
      }
      
      public function analyzer(param1:DDTKingGradeAnalyzer) : void
      {
         _data = param1.data;
      }
      
      public function get data() : DictionaryData
      {
         return _data;
      }
      
      public function getInfoByCost(param1:int) : DDTKingGradeInfo
      {
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = _data;
         for each(var _loc3_ in _data)
         {
            if(param1 >= _loc3_.Cost)
            {
               _loc2_ = _loc3_;
            }
         }
         return _loc2_;
      }
   }
}
