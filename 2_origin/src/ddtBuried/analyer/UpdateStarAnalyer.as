package ddtBuried.analyer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddtBuried.data.UpdateStarData;
   
   public class UpdateStarAnalyer extends DataAnalyzer
   {
       
      
      public var itemList:Vector.<UpdateStarData>;
      
      public function UpdateStarAnalyer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var i:int = 0;
         var itemData:* = null;
         itemList = new Vector.<UpdateStarData>();
         var xml:XML = new XML(data);
         var len:int = xml.Item.length();
         var xmllist:XMLList = xml.item;
         for(i = 0; i < xmllist.length(); )
         {
            itemData = new UpdateStarData();
            ObjectUtils.copyPorpertiesByXML(itemData,xmllist[i]);
            itemList.push(itemData);
            i++;
         }
         onAnalyzeComplete();
      }
   }
}
