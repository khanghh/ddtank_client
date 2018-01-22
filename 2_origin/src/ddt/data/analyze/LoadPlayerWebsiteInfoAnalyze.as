package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import flash.utils.Dictionary;
   
   public class LoadPlayerWebsiteInfoAnalyze extends DataAnalyzer
   {
       
      
      public var info:Dictionary;
      
      public function LoadPlayerWebsiteInfoAnalyze(param1:Function)
      {
         info = new Dictionary(true);
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc2_:XML = new XML(param1);
         if(_loc2_)
         {
            info["uid"] = _loc2_.uid.toString();
            info["name"] = _loc2_.name.toString();
            info["gender"] = _loc2_.gender.toString();
            info["userName"] = _loc2_.userName.toString();
            info["university"] = _loc2_.university.toString();
            info["city"] = _loc2_.city.toString();
            info["tinyHeadUrl"] = _loc2_.tinyHeadUrl.toString();
            info["largeHeadUrl"] = _loc2_.largeHeadUrl.toString();
            info["personWeb"] = _loc2_.personWeb.toString();
            onAnalyzeComplete();
         }
         else
         {
            message = _loc2_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
