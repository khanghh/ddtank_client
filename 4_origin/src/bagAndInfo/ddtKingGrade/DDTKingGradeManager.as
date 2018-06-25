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
         var view:* = undefined;
         if(isOpen == false)
         {
            isOpen = true;
            view = ComponentFactory.Instance.creatComponentByStylename("ddtKingGrade.mainView");
            view.show();
         }
      }
      
      public function analyzer(analyzer:DDTKingGradeAnalyzer) : void
      {
         _data = analyzer.data;
      }
      
      public function get data() : DictionaryData
      {
         return _data;
      }
      
      public function getInfoByCost(value:int) : DDTKingGradeInfo
      {
         var result:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = _data;
         for each(var info in _data)
         {
            if(value >= info.Cost)
            {
               result = info;
            }
         }
         return result;
      }
   }
}
