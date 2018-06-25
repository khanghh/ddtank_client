package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.EquipSuitTemplateInfo;
   import ddt.data.goods.SuitTemplateInfo;
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   
   public class EquipSuitTempleteAnalyzer extends DataAnalyzer
   {
       
      
      private var _dic:Dictionary;
      
      private var _data:Dictionary;
      
      public function EquipSuitTempleteAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var ecInfo:* = null;
         var i:int = 0;
         var info:* = null;
         var arr:* = null;
         _dic = new Dictionary();
         _data = new Dictionary();
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml..item;
            ecInfo = describeType(new SuitTemplateInfo());
            for(i = 0; i < xmllist.length(); )
            {
               info = new EquipSuitTemplateInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               if(_dic[info.ID])
               {
                  arr = _dic[info.ID];
               }
               else
               {
                  arr = [];
                  _dic[info.ID] = arr;
               }
               arr.push(info);
               _data[info.PartName] = info;
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
      
      public function get dic() : Dictionary
      {
         return _dic;
      }
      
      public function get data() : Dictionary
      {
         return _data;
      }
   }
}
