package totem.data
{
   import com.pickgliss.loader.DataAnalyzer;
   import road7th.data.DictionaryData;
   
   public class TotemUpGradeAnalyz extends DataAnalyzer
   {
       
      
      private var _dataLists:DictionaryData;
      
      public function TotemUpGradeAnalyz(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var _types:int = 0;
         var _templateID:int = 0;
         var _grades:int = 0;
         var _data:int = 0;
         var _templateName:* = null;
         var _itemTempID1:int = 0;
         var _param1:int = 0;
         var _itemTempID2:int = 0;
         var _param2:int = 0;
         var i:int = 0;
         var info:* = null;
         var xml:XML = new XML(data);
         _dataLists = new DictionaryData();
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new TotemUpGradDataVo();
               info.types = xmllist[i].@Types;
               info.templateId = xmllist[i].@TemplateId;
               info.grades = xmllist[i].@Grades;
               info.data = xmllist[i].@Data;
               info.templateName = xmllist[i].@TemplateName;
               info.itemTempId1 = xmllist[i].@ItemTempId1;
               info.param1 = xmllist[i].@Param1;
               info.itemTempId2 = xmllist[i].@ItemTempId2;
               info.param2 = xmllist[i].@Param2;
               if(!_dataLists.hasKey(info.templateId))
               {
                  _dataLists.add(info.templateId,[]);
               }
               (_dataLists[info.templateId] as Array).push(info);
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
         }
      }
      
      public function get dataList() : DictionaryData
      {
         return _dataLists;
      }
   }
}
