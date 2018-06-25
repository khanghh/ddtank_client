package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import ddt.data.CMFriendInfo;
   import ddt.manager.PlayerManager;
   import road7th.data.DictionaryData;
   
   public class LoadCMFriendList extends DataAnalyzer
   {
       
      
      public function LoadCMFriendList(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var i:int = 0;
         var info:* = null;
         var sex:int = 0;
         var tmp:* = null;
         var _cmFriendList:DictionaryData = new DictionaryData();
         var xml:XML = new XML(data);
         var xmllist:XMLList = xml..Item;
         if(xml.@value == "true")
         {
            for(i = 0; i < xmllist.length(); )
            {
               info = new CMFriendInfo();
               info.NickName = xmllist[i].@NickName;
               info.UserName = xmllist[i].@UserName;
               info.UserId = xmllist[i].@UserId;
               info.Photo = xmllist[i].@Photo;
               info.PersonWeb = xmllist[i].@PersonWeb;
               info.OtherName = xmllist[i].@OtherName;
               info.level = xmllist[i].@Level;
               sex = xmllist[i].@Sex;
               if(sex == 0)
               {
                  info.sex = false;
               }
               else
               {
                  info.sex = true;
               }
               tmp = xmllist[i].@IsExist;
               if(tmp == "true")
               {
                  info.IsExist = true;
               }
               else
               {
                  info.IsExist = false;
               }
               if(!(info.IsExist && PlayerManager.Instance.friendList[info.UserId]))
               {
                  _cmFriendList.add(info.UserName,info);
               }
               i++;
            }
            PlayerManager.Instance.CMFriendList = _cmFriendList;
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
