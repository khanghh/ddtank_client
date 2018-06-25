package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.email.EmailInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import email.MailManager;
   import flash.utils.describeType;
   import road7th.utils.DateUtils;
   
   public class AllEmailAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Array;
      
      public function AllEmailAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var ecInfo:* = null;
         var icInfo:* = null;
         var i:int = 0;
         var info:* = null;
         var subXmllist:* = null;
         var j:int = 0;
         var temp:* = null;
         var itemInfo:* = null;
         _list = [];
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            MailManager.Instance.Model.lastTime = xml.@Time;
            xmllist = xml.Item;
            ecInfo = describeType(new EmailInfo());
            icInfo = describeType(new InventoryItemInfo());
            for(i = 0; i < xmllist.length(); )
            {
               info = new EmailInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               subXmllist = xmllist[i].Item;
               for(j = 0; j < subXmllist.length(); )
               {
                  temp = new InventoryItemInfo();
                  ObjectUtils.copyPorpertiesByXML(temp,subXmllist[j]);
                  itemInfo = ItemManager.fill(temp);
                  info["Annex" + getAnnexPos(info,temp)] = temp;
                  temp.isGold = subXmllist[j].@IsGold == "true"?true:false;
                  temp.goldBeginTime = String(subXmllist[j].@GoldBeginTime);
                  temp.goldValidDate = int(subXmllist[j].@GoldVaild);
                  temp.latentEnergyCurStr = String(subXmllist[j].@AvatarPotentialProperty);
                  temp.latentEnergyEndTime = DateUtils.getDateByStr(String(subXmllist[j].@AvatarRemoveDate));
                  temp.MagicAttack = int(subXmllist[j].@MagicAttack);
                  temp.MagicDefence = int(subXmllist[j].@MagicDefence);
                  temp.MagicLevel = int(subXmllist[j].@MagicLevel);
                  info.UserID = itemInfo.UserID;
                  j++;
               }
               if(!SharedManager.Instance.deleteMail[PlayerManager.Instance.Self.ID] || SharedManager.Instance.deleteMail[PlayerManager.Instance.Self.ID].indexOf(info.ID) < 0)
               {
                  _list.push(info);
               }
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
      
      public function get list() : Array
      {
         _list.reverse();
         return _list;
      }
      
      private function getAnnexPos(info:EmailInfo, itempInfo:InventoryItemInfo) : int
      {
         var i:* = 0;
         for(i = uint(1); i <= 5; )
         {
            if(info["Annex" + i + "ID"] == itempInfo.ItemID)
            {
               return i;
            }
            i++;
         }
         return 1;
      }
   }
}
