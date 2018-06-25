package draft.data
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class DraftListAnalyzer extends DataAnalyzer
   {
       
      
      private var _draftInfoVec:Vector.<DraftModel>;
      
      public function DraftListAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         var arr:* = null;
         _draftInfoVec = new Vector.<DraftModel>();
         var xmlData:XML = new XML(data);
         if(xmlData.@value == "true")
         {
            DraftModel.Total = xmlData.@total;
            xmllist = xmlData..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new DraftModel();
               info.id = xmllist[i].@ID;
               info.ticketNum = xmllist[i].@Count;
               info.playerInfo.ID = xmllist[i].@UserID;
               info.playerInfo.NickName = xmllist[i].@NickName;
               info.playerInfo.Style = xmllist[i].@Style;
               arr = xmllist[i].@Color.split("#");
               info.playerInfo.Colors = arr[0];
               info.playerInfo.Skin = arr[1];
               _draftInfoVec.push(info);
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xmlData.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
      
      public function get draftInfoVec() : Vector.<DraftModel>
      {
         return _draftInfoVec;
      }
   }
}
