package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.FriendListPlayer;
   import ddt.data.player.PlayerState;
   import ddt.manager.IMManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import im.CustomInfo;
   import road7th.data.DictionaryData;
   
   public class FriendListAnalyzer extends DataAnalyzer
   {
       
      
      public var customList:Vector.<CustomInfo>;
      
      public var friendlist:DictionaryData;
      
      public var blackList:DictionaryData;
      
      public function FriendListAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var list:* = null;
         var li:int = 0;
         var customInfo:* = null;
         var n:int = 0;
         var tempInfo:* = null;
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         var dateStr:* = null;
         var birthdayArr:* = null;
         var statePlayerState:* = null;
         var xml:XML = new XML(data);
         friendlist = new DictionaryData();
         blackList = new DictionaryData();
         customList = new Vector.<CustomInfo>();
         if(xml.@value == "true")
         {
            list = xml..customList;
            for(li = 0; li < list.length(); )
            {
               if(list[li].@Name != "")
               {
                  customInfo = new CustomInfo();
                  ObjectUtils.copyPorpertiesByXML(customInfo,list[li]);
                  customList.push(customInfo);
               }
               li++;
            }
            for(n = 0; n < customList.length; )
            {
               if(customList[n].ID == 1)
               {
                  tempInfo = customList[n];
                  customList.splice(n,1);
                  customList.push(tempInfo);
               }
               n++;
            }
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new FriendListPlayer();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               info.isOld = int(xmllist[i].@OldPlayer) == 1;
               info.ddtKingGrade = int(xmllist[i].@MaxLevelLevel);
               dateStr = String(xmllist[i].@LastDate).replace(/-/g,"/");
               info.LastLoginDate = new Date(dateStr);
               if(info.Birthday != "Null")
               {
                  birthdayArr = info.Birthday.split(/-/g);
                  info.BirthdayDate = new Date();
                  info.BirthdayDate.fullYearUTC = Number(birthdayArr[0]);
                  info.BirthdayDate.monthUTC = birthdayArr[1] - 1;
                  info.BirthdayDate.dateUTC = Number(birthdayArr[2]);
               }
               statePlayerState = new PlayerState(int(xml.Item[i].@State));
               info.playerState = statePlayerState;
               info.apprenticeshipState = xml.Item[i].@ApprenticeshipState;
               info.IsShow = xml.Item[i].@IsShow == "true"?true:false;
               info.ImagePath = xml.Item[i].@ImagePath;
               info.isAttest = xml.Item[i].@IsBeauty == "false"?false:true;
               if(info.Relation != 1)
               {
                  friendlist.add(info.ID,info);
               }
               else
               {
                  blackList.add(info.ID,info);
               }
               i++;
            }
            if(PlayerManager.Instance.Self.IsFirst == 1 && PathManager.CommunityExist())
            {
               IMManager.Instance.createConsortiaLoader();
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
   }
}
