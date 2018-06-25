package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import flash.utils.Dictionary;
   
   public class LoadPlayerWebsiteInfoAnalyze extends DataAnalyzer
   {
       
      
      public var info:Dictionary;
      
      public function LoadPlayerWebsiteInfoAnalyze(onCompleteCall:Function)
      {
         info = new Dictionary(true);
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xml:XML = new XML(data);
         if(xml)
         {
            info["uid"] = xml.uid.toString();
            info["name"] = xml.name.toString();
            info["gender"] = xml.gender.toString();
            info["userName"] = xml.userName.toString();
            info["university"] = xml.university.toString();
            info["city"] = xml.city.toString();
            info["tinyHeadUrl"] = xml.tinyHeadUrl.toString();
            info["largeHeadUrl"] = xml.largeHeadUrl.toString();
            info["personWeb"] = xml.personWeb.toString();
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
