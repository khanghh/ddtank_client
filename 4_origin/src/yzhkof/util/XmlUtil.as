package yzhkof.util
{
   public class XmlUtil
   {
       
      
      public function XmlUtil()
      {
         super();
      }
      
      public static function deleteXmlList(xml_list:XMLList) : void
      {
         var length:int = xml_list.length();
         for(var i:int = 0; i < length; i++)
         {
            delete xml_list[0];
         }
      }
      
      public static function sortOnXMLList(xmllist:XMLList, fieldName:Object, options:Object = null) : XMLList
      {
         var x:XML = null;
         var sort_arr:Array = new Array();
         for each(x in xmllist)
         {
            sort_arr.push(x);
         }
         if(fieldName)
         {
            sort_arr.sortOn(fieldName,options);
         }
         else
         {
            sort_arr.sort();
         }
         var re_xmllist:XMLList = new XMLList();
         for each(x in sort_arr)
         {
            re_xmllist = re_xmllist + x;
         }
         return re_xmllist;
      }
      
      public static function enableSpecialCode(str:String) : String
      {
         return str.replace("\\n","\n");
      }
   }
}
