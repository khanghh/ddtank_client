package ddt.view.chat
{
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.QualityType;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.utils.Helpers;
   import flash.text.StyleSheet;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import newTitle.NewTitleManager;
   import redEnvelope.view.RedEnvelopeItem;
   import road7th.utils.StringHelper;
   
   public class ChatFormats
   {
      
      public static const CHAT_COLORS:Array = [2358015,16751360,16740090,4970320,8423901,16777215,16776960,16776960,16776960,16777215,5035345,16724787,16777011,16777215,16711846,16711680,16777215,16777215,16777215,16777215,16777215,16777215,16777215,16777215,16777215,16777215,16777215,16777215,10170623,13369599];
      
      public static const BIG_BUGGLE_COLOR:Array = [11408476,16635586,15987916,16514727,12053748];
      
      public static const BIG_BUGGLE_TYPE_STRING:Array = ["Mối tình đầu","Chúc mừng sinh nhật","Lá lành đùm lá rách","Vua thách đấu","Đời không đối thủ","Noen vui vẻ "];
      
      public static const TITLE_COLORS:Array = [11423743,54015,16731330,16743936];
      
      public static const CLICK_CHANNEL:int = 0;
      
      public static const CLICK_GOODS:int = 2;
      
      public static const CLICK_USERNAME:int = 1;
      
      public static const CLICK_DIFF_ZONE:int = 4;
      
      public static const CLICK_INVENTORY_GOODS:int = 3;
      
      public static const CLICK_EFFORT:int = 100;
      
      public static const CLICK_FASTINVITE:int = 101;
      
      public static const CLICK_ENTERHUIKUI_ACTIVITY:int = 102;
      
      public static const CLICK_INVITE_OLD_PLAYER:int = 103;
      
      public static const CLICK_LANTERN_BEGIN:int = 104;
      
      public static const CLICK_TIME_GIFTPACK:int = 105;
      
      public static const CLICK_NO_TIP:int = 106;
      
      public static const CLICK_SIMPLE_TOLINK:int = 99;
      
      public static const CLICK_FASTAUCTION:int = 107;
      
      public static const AVATAR_COLLECTION_TIP:int = 108;
      
      public static const CLICK_INVITE_WAKE:int = 109;
      
      public static const CLICK_FARMBOSS_FULLLEVEL:int = 110;
      
      public static const GOTO_RED_PACKAGE:int = 111;
      
      public static var CLICK_ACT_TIP:int = 1000;
      
      public static const NEWYEARFOOD:int = 888;
      
      public static const REDENVELOPE:int = 999;
      
      public static const HORESRACE:int = 889;
      
      public static const GMCHAT:int = 890;
      
      public static const GOTO_CONSORTIA_BACK_PACKAGE:int = 112;
      
      public static const GOTO_CONSORTIA_DOMAIN_SCENE:int = 113;
      
      public static const COMPLATE_TASK:int = 114;
      
      public static const DAILY_GLODEQUIP:int = 32;
      
      public static const DAILY_POTENTIAL:int = 33;
      
      public static const CARD_CAO:int = 5;
      
      public static const CLICK_CARD_INFO:int = 6;
      
      public static const Channel_Set:Object = {
         0:LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.big"),
         1:LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.small"),
         2:LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.private"),
         3:LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.consortia"),
         4:LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.ream"),
         5:LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.current"),
         9:LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.current"),
         12:LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.cross"),
         13:LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.current"),
         15:LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.crossBugle"),
         25:LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.current")
      };
      
      public static var hasYaHei:Boolean;
      
      private static var _formats:Dictionary;
      
      private static var _styleSheet:StyleSheet;
      
      private static var _gameStyleSheet:StyleSheet;
      
      private static var _styleSheetData:Dictionary;
      
      private static var _chatData:ChatData;
      
      private static const unacceptableChar:Array = ["\"","\'","<",">"];
      
      private static const IN_GAME:uint = 1;
      
      private static const NORMAL:uint = 0;
       
      
      public function ChatFormats()
      {
         super();
      }
      
      public static function formatChatStyle(data:ChatData) : void
      {
         if(data.htmlMessage != "")
         {
            return;
         }
         data.msg = StringHelper.rePlaceHtmlTextField(data.msg);
         var channelTag:Array = getTagsByChannel(data);
         var channelClickTag:String = creatChannelTag(data.channel,data.bigBuggleType,data);
         var senderClickTag:String = creatSenderTag(data);
         var contentClickTag:String = creatContentTag(data);
         data.htmlMessage = channelTag[0] + channelClickTag + senderClickTag + contentClickTag + channelTag[1] + "<BR>";
      }
      
      public static function formatComplexChatStyle(data:ChatData) : void
      {
         var i:int = 0;
         if(data.htmlMessage != "")
         {
            return;
         }
         data.msg = StringHelper.rePlaceHtmlTextField(data.msg);
         var channelTag:Array = getTagsByChannel(data);
         var contentClickTag:String = creatContentTag(data);
         var contentArray:Array = contentClickTag.split("@@");
         for(i = 0; i < contentArray.length; )
         {
            data.htmlMessage = data.htmlMessage + (channelTag[2 * i] + contentArray[i] + channelTag[2 * i + 1]);
            i++;
         }
         data.htmlMessage = data.htmlMessage + "<BR>";
      }
      
      public static function creatBracketsTag(source:String, clickType:int, args:Array = null, data:ChatData = null) : String
      {
         var tmp:* = null;
         var index:int = 0;
         var invitStr:* = null;
         var rep:* = null;
         var nameArr:* = null;
         var name:* = null;
         var namesRec:* = null;
         var srr:* = null;
         var argString:* = null;
         var i:int = 0;
         var tagname:* = null;
         if(data != null && data.channel == 14 && data.msg.indexOf("http") != -1)
         {
            source = "<u><a href=\"event:clicktype:" + clickType.toString() + "|senderId:" + data.senderID + "|roomId:" + data.roomId + "|password:" + data.password + "|source:" + data.msg + "\">" + source + "</a>" + "</u>";
         }
         if(clickType == 101)
         {
            source = "<u><a href=\"event:clicktype:" + clickType.toString() + "|senderId:" + data.senderID + "|roomId:" + data.roomId + "|password:" + data.password + "\">" + source + "</a>" + "</u>";
         }
         if(clickType == 888)
         {
            if(data.senderID != PlayerManager.Instance.Self.ID)
            {
               source = "<u><a href=\"event:clicktype:" + clickType.toString() + "|senderId:" + data.senderID + "|roomId:" + data.roomId + "|password:" + data.password + "\">" + source + "</a>" + "</u>";
            }
            else
            {
               source = "【" + data.sender + "】" + LanguageMgr.GetTranslation("tank.newyearFood.view.bugleTxt");
            }
         }
         if(clickType == 889)
         {
            source = source.split("|")[0] + "@@" + "<u>" + "<a href=\"event:" + "clicktype:" + clickType.toString() + "\">" + source.split("|")[1] + "</a>" + "</u>";
         }
         if(clickType == 107)
         {
            source = "【" + data.sender + "】" + LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionSellLeftView.bugleTxt",data.price,data.mouthful,data.auctionGoodName,data.itemCount);
            if(data.playerCharacterID != PlayerManager.Instance.Self.ID)
            {
               source = source + ("，<u><a href=\"event:clicktype:" + clickType.toString() + "|senderId:" + data.senderID + "|nickName:" + data.playerName + "|price:" + data.price + "|mouthful:" + data.mouthful + "|auctionID:" + data.auctionID + "\">" + LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionSellLeftView.clickToBuy") + "</a></u>");
            }
         }
         else if(clickType == 102 || clickType == 108 || clickType == 110 || clickType > CLICK_ACT_TIP)
         {
            source = source.split("|")[0] + "@@" + "<u>" + "<a href=\"event:" + "clicktype:" + clickType.toString() + "|rewardType:" + data.actId + "\">" + source.split("|")[1] + "</a>" + "</u>";
         }
         else if(clickType == 113)
         {
            source = source.split("|")[0] + "<u>" + "<a href=\"event:" + "clicktype:" + clickType.toString() + "\">" + source.split("|")[1] + "</a>" + "</u>";
         }
         else if(clickType == 32 || clickType == 33)
         {
            source = source.split("|")[0] + "@@" + "<u>" + "<a href=\"event:" + "clicktype:" + clickType.toString() + "\">" + source.split("|")[1] + "</a>" + "</u>";
         }
         else if(clickType == 103)
         {
            tmp = source.split("|");
            source = tmp[0];
            if(data.receiver != PlayerManager.Instance.Self.NickName)
            {
               source = source.replace("[" + data.receiver + "]","<a href=\"event:clicktype:1|tagname:" + data.receiver + "|zoneID:-1\">" + Helpers.enCodeString("[" + data.receiver + "]") + "</a>");
            }
            if(tmp.length > 1)
            {
               source = source + ("@@<u><a href=\"event:clicktype:" + clickType + "|tagname:" + data.receiver + "\">" + tmp[1] + "</a>" + "</u>");
            }
            else
            {
               source = source + "@@";
            }
         }
         else if(clickType == 104)
         {
            index = source.indexOf(".") + 1;
            source = source.slice(0,index) + "<u>" + "<a href=\"event:" + "clicktype:" + clickType.toString() + "\">" + source.slice(index,source.length) + "</a></u>";
         }
         else if(clickType == 106)
         {
            source = source + ("<u><a href=\"event:clicktype:" + clickType.toString() + "\"><FONT  COLOR=\'#8dff1e\'>" + LanguageMgr.GetTranslation("notAlertAgain") + "</FONT></a></u>");
         }
         else if(clickType == 109)
         {
            invitStr = source.split("|");
            rep = /\[([^\]]*)]*/g;
            nameArr = invitStr[0].match(rep);
            name = nameArr[0].substr(1,nameArr[0].length - 2);
            source = invitStr[0].replace("[" + name + "]","<a href=\"event:clicktype:1|tagname:" + name + "|zoneID:" + String(data.zoneID) + "|zoneName:" + String(data.zoneName) + "|" + "\">" + Helpers.enCodeString("[" + name + "]") + "</a>") + "@@<u>" + invitStr[1].replace(invitStr[1],"<a href=\"event:clicktype:" + clickType.toString() + "|tagname:" + name + "|zoneID:" + String(data.zoneID) + "|zoneName:" + String(data.zoneName) + "|" + "\">" + Helpers.enCodeString(invitStr[1]) + "</a></u>");
         }
         else if(clickType == 111)
         {
            source = source + ("<u><a href=\"event:clicktype:" + clickType.toString() + "\">" + LanguageMgr.GetTranslation("redpackage.clickToGain") + "</a></u>");
         }
         else if(clickType == 999)
         {
            source = source + ("<font color=\"" + RedEnvelopeItem.redcolorList[data.redType - 1] + "\"> " + LanguageMgr.GetTranslation("ddt.redEnvelope.red" + String(data.redType)) + "</font>");
            source = source + ("<u><a href=\"event:clicktype:" + clickType.toString() + "\">" + LanguageMgr.GetTranslation("ddt.redEnvelope.chatClick") + "</a></u>");
         }
         else if(clickType == 112)
         {
            source = "<u><a href=\"event:clicktype:" + clickType.toString() + "\">" + source + "</a>" + "</u>";
         }
         else
         {
            namesRec = /\[([^\]]*)]*/g;
            srr = source.match(namesRec);
            argString = "";
            if(args)
            {
               argString = args.join("|");
            }
            i = 0;
            while(i < srr.length)
            {
               tagname = srr[i].substr(1,srr[i].length - 2);
               if(clickType != 1 || tagname != PlayerManager.Instance.Self.NickName || tagname == PlayerManager.Instance.Self.NickName && data && data.zoneID != PlayerManager.Instance.Self.ZoneID)
               {
                  if(data)
                  {
                     argString = argString + ("channel:" + data.channel);
                  }
                  if(data && data.channel == 12)
                  {
                     source = source.replace("[" + tagname + "]","<a href=\"event:clicktype:" + clickType.toString() + "|tagname:" + tagname + "|zoneID:" + String(data.zoneID) + "|zoneName:" + String(data.zoneName) + "|" + argString + "\">" + Helpers.enCodeString("[" + tagname + "]") + "</a>");
                  }
                  else if(tagname == Channel_Set[12])
                  {
                     source = "";
                  }
                  else if(data)
                  {
                     if(data.senderID >= 0)
                     {
                        source = source.replace("[" + tagname + "]","<a href=\"event:clicktype:" + clickType.toString() + "|tagname:" + tagname + "|zoneID:" + String(data.zoneID) + "|zoneName:" + String(data.zoneName) + "|" + argString + "\">" + Helpers.enCodeString("[" + tagname + "]") + "</a>");
                     }
                     else
                     {
                        source = source.replace("[" + tagname + "]","<a href=\"event:clicktype:" + clickType.toString() + "|tagname:" + tagname + "|senderID:" + data.senderID + "|zoneID:" + String(data.zoneID) + "|zoneName:" + String(data.zoneName) + "|" + argString + "\">" + Helpers.enCodeString("[" + tagname + "]") + "</a>");
                     }
                  }
                  else
                  {
                     source = source.replace("[" + tagname + "]","<a href=\"event:clicktype:" + clickType.toString() + "|tagname:" + tagname + "|" + argString + "\">" + Helpers.enCodeString("[" + tagname + "]") + "</a>");
                  }
               }
               else
               {
                  source = source.replace("[" + tagname + "]",Helpers.enCodeString("[" + tagname + "]"));
               }
               i++;
            }
         }
         return source;
      }
      
      public static function creatGoodTag(source:String, clickType:int, templeteIDorItemID:int, quality:int, isBind:Boolean, data:ChatData = null, key:String = "", $type:int = -1) : String
      {
         var i:int = 0;
         var tagname:* = null;
         var qualityTag:Array = getTagsByQuality(quality);
         var namesRec:RegExp = /\[([^\]]*)]*/g;
         var srr:Array = source.match(namesRec);
         var zoneID:int = data.zoneID;
         for(i = 0; i < srr.length; )
         {
            tagname = srr[i].substr(1,srr[i].length - 2);
            source = source.replace("[" + tagname + "]",qualityTag[0] + "<a href=\"event:" + "clicktype:" + clickType.toString() + "|type:" + $type + "|tagname:" + tagname + "|isBind:" + isBind.toString() + "|templeteIDorItemID:" + templeteIDorItemID.toString() + "|key:" + key + "|zoneID:" + zoneID + "\">" + Helpers.enCodeString("[" + tagname + "]") + "</a>" + qualityTag[1]);
            i++;
         }
         return source;
      }
      
      public static function getColorByChannel(channel:int) : int
      {
         return CHAT_COLORS[channel];
      }
      
      public static function getColorByBigBuggleType(type:int) : int
      {
         return BIG_BUGGLE_COLOR[type];
      }
      
      public static function getTagsByChannel(data:ChatData) : Array
      {
         var ctArray:* = null;
         var i:int = 0;
         if(data.channel != 21)
         {
            return ["<CT" + data.channel.toString() + ">","</CT" + data.channel.toString() + ">"];
         }
         ctArray = [];
         for(i = 0; i < data.childChannelArr.length; )
         {
            ctArray.push("<CT" + data.childChannelArr[i].toString() + ">");
            ctArray.push("</CT" + data.childChannelArr[i].toString() + ">");
            i++;
         }
         return ctArray;
      }
      
      public static function getTagsByQuality(quality:int) : Array
      {
         return ["<QT" + quality.toString() + ">","</QT" + quality.toString() + ">"];
      }
      
      public static function getTextFormatByChannel(channelid:int) : TextFormat
      {
         return _formats[channelid];
      }
      
      public static function setup() : void
      {
         setupFormat();
         setupStyle();
      }
      
      public static function get styleSheet() : StyleSheet
      {
         return _styleSheet;
      }
      
      public static function get gameStyleSheet() : StyleSheet
      {
         return _gameStyleSheet;
      }
      
      private static function getBigBuggleTypeString(type:int) : String
      {
         return BIG_BUGGLE_TYPE_STRING[type - 1];
      }
      
      private static function creatChannelTag(channel:int, bigBuggleType:int = 0, chdata:ChatData = null) : String
      {
         var result:String = "";
         if(Channel_Set[channel] && channel != 2)
         {
            if(bigBuggleType == 0)
            {
               if(channel != 15)
               {
                  result = creatBracketsTag("[" + Channel_Set[channel] + "]",0,["channel:" + channel.toString()]);
               }
               else
               {
                  result = creatBracketsTag("[" + Channel_Set[channel] + "]" + "&lt;" + chdata.zoneName + "&gt;",0,["channel:" + channel.toString()]);
               }
            }
            else
            {
               result = "[" + getBigBuggleTypeString(bigBuggleType) + Channel_Set[channel] + "]";
            }
         }
         return result;
      }
      
      private static function creatContentTag(data:ChatData) : String
      {
         var ItemID:Number = NaN;
         var TemplateID:int = 0;
         var info:* = null;
         var key:* = null;
         var index:* = 0;
         var tag:* = null;
         var result:String = data.msg;
         var offset:uint = 0;
         if(data.link)
         {
            data.link.sortOn("index");
            var _loc12_:int = 0;
            var _loc11_:* = data.link;
            for each(var i in data.link)
            {
               ItemID = i.ItemID;
               TemplateID = i.TemplateID;
               info = ItemManager.Instance.getTemplateById(TemplateID);
               key = i.key;
               index = uint(i.index + offset);
               if(ItemID <= 0)
               {
                  if(info.CategoryID == 26)
                  {
                     tag = creatGoodTag("[" + info.Name + "]",6,ItemID,info.Quality,true,data,key);
                  }
                  else
                  {
                     tag = creatGoodTag("[" + info.Name + "]",2,info.TemplateID,info.Quality,true,data);
                  }
               }
               else if(info == null)
               {
                  if(TemplateID == 0)
                  {
                     tag = creatGoodTag("[" + LanguageMgr.GetTranslation("tank.view.card.chatLinkText0") + "]",5,ItemID,2,true,data,key);
                  }
                  else
                  {
                     tag = creatGoodTag("[" + String(TemplateID) + LanguageMgr.GetTranslation("tank.view.card.chatLinkText") + "]",5,ItemID,2,true,data,key);
                  }
               }
               else
               {
                  tag = creatGoodTag("[" + info.Name + "]",3,ItemID,info.Quality,true,data,key);
               }
               result = result.substring(0,index) + tag + result.substring(index);
               offset = offset + tag.length;
            }
         }
         if(data.type == 113)
         {
            result = creatBracketsTag(result,113,null,data);
            return creatBracketsTag(result,113,null,data);
         }
         if(data.type == 110)
         {
            result = creatBracketsTag(result,110,null,data);
            return creatBracketsTag(result,110,null,data);
         }
         if(data.type == 109)
         {
            result = creatBracketsTag(result,109,null,data);
            return creatBracketsTag(result,109,null,data);
         }
         if(data.type == 99)
         {
            return StringHelper.reverseHtmlTextField(data.msg);
         }
         if(data.type == 100)
         {
            result = creatBracketsTag(result,100,null,data);
            return creatBracketsTag(result,100,null,data);
         }
         if(data.type == 101)
         {
            result = creatBracketsTag(result,101,null,data);
            return creatBracketsTag(result,101,null,data);
         }
         if(data.type == 888)
         {
            result = creatBracketsTag(result,888,null,data);
            return creatBracketsTag(result,888,null,data);
         }
         if(data.type == 889)
         {
            result = creatBracketsTag(result,889,null,data);
            return creatBracketsTag(result,889,null,data);
         }
         if(data.type == 107)
         {
            result = creatBracketsTag(result,107,null,data);
            return creatBracketsTag(result,107,null,data);
         }
         if(data.type == 102)
         {
            result = creatBracketsTag(result,102,null,data);
            return creatBracketsTag(result,102,null,data);
         }
         if(data.type == 102 || data.type == 108)
         {
            result = creatBracketsTag(result,data.type,null,data);
            return creatBracketsTag(result,data.type,null,data);
         }
         if(data.type == 32)
         {
            result = creatBracketsTag(result,32,null,data);
            return creatBracketsTag(result,32,null,data);
         }
         if(data.type == 33)
         {
            result = creatBracketsTag(result,33,null,data);
            return creatBracketsTag(result,33,null,data);
         }
         if(data.type == 108 || data.type > CLICK_ACT_TIP)
         {
            result = creatBracketsTag(result,data.type,null,data);
            return creatBracketsTag(result,data.type,null,data);
         }
         if(data.type == 103)
         {
            result = creatBracketsTag(result,103,null,data);
            return creatBracketsTag(result,103,null,data);
         }
         if(data.type == 104 || data.type == 105)
         {
            result = creatBracketsTag(result,data.type,null,data);
            return creatBracketsTag(result,data.type,null,data);
         }
         if(data.type == 106)
         {
            result = creatBracketsTag(result,data.type,null,data);
            return creatBracketsTag(result,data.type,null,data);
         }
         if(data.type == 111)
         {
            result = creatBracketsTag(result,data.type,null,data);
            return creatBracketsTag(result,data.type,null,data);
         }
         if(data.type == 999)
         {
            result = creatBracketsTag(result,data.type,null,data);
            return creatBracketsTag(result,data.type,null,data);
         }
         if(data.channel == 14)
         {
            result = creatBracketsTag(result,890,null,data);
            return creatBracketsTag(result,890,null,data);
         }
         if(data.channel <= 5)
         {
            if(data.type == 1 || data.type == 4)
            {
               result = creatBracketsTag(result,1,null,data);
               return creatBracketsTag(result,1,null,data);
            }
            return result;
         }
         result = creatBracketsTag(result,1,null,data);
         return creatBracketsTag(result,1,null,data);
      }
      
      private static function creatSenderTag(data:ChatData) : String
      {
         var result:String = "";
         if(data.sender == "")
         {
            return result;
         }
         if(data.channel == 2)
         {
            if(data.zoneID <= 0 || !data.zoneName)
            {
               if(data.sender == PlayerManager.Instance.Self.NickName)
               {
                  result = creatBracketsTag(LanguageMgr.GetTranslation("tank.view.chatsystem.sendTo") + "[" + data.receiver + "]: ",1,null,data);
               }
               else
               {
                  result = creatBracketsTag("[" + data.sender + "]" + LanguageMgr.GetTranslation("tank.view.chatsystem.privateSayToYou"),1,null,data);
               }
            }
            else if(data.sender == PlayerManager.Instance.Self.NickName && data.senderID == PlayerManager.Instance.Self.ID)
            {
               result = creatBracketsTag(LanguageMgr.GetTranslation("tank.view.chatsystem.sendTo") + "&lt;" + data.zoneName + "&gt;" + "[" + data.receiver + "]: ",1,null,data);
            }
            else
            {
               result = creatBracketsTag("&lt;" + data.zoneName + "&gt;" + "[" + data.sender + "]" + LanguageMgr.GetTranslation("tank.view.chatsystem.privateSayToYou"),1,null,data);
            }
         }
         else if(data.zoneID == PlayerManager.Instance.Self.ZoneID || data.zoneID <= 0)
         {
            result = creatBracketsTag("[" + data.sender + "]: ",1,null,data);
         }
         else
         {
            result = creatBracketsTag("[" + data.sender + "]: ",4,null,data);
         }
         return result;
      }
      
      public static function replaceUnacceptableChar(source:String) : String
      {
         var i:int = 0;
         for(i = 0; i < unacceptableChar.length; )
         {
            source = source.replace(unacceptableChar[i],"");
            i++;
         }
         return source;
      }
      
      private static function creatStyleObject(color:int, type:uint = 0) : Object
      {
         var styleObject:* = null;
         var fontSize:* = null;
         switch(int(type))
         {
            case 0:
               fontSize = "13";
               break;
            case 1:
               fontSize = "12";
         }
         styleObject = {
            "color":"#" + color.toString(16),
            "leading":"5",
            "fontFamily":"Arial",
            "display":"inline",
            "fontSize":fontSize
         };
         return styleObject;
      }
      
      private static function setupFormat() : void
      {
         var i:int = 0;
         var format:* = null;
         _formats = new Dictionary();
         for(i = 0; i < CHAT_COLORS.length; )
         {
            format = new TextFormat();
            format.font = "Arial";
            format.size = 13;
            format.color = CHAT_COLORS[i];
            _formats[i] = format;
            i++;
         }
      }
      
      private static function setupStyle() : void
      {
         var i:int = 0;
         var ct:* = null;
         var gct:* = null;
         var j:int = 0;
         var ct1:* = null;
         var gct1:* = null;
         var k:int = 0;
         var ct2:* = null;
         var gct2:* = null;
         var ctID:* = null;
         _styleSheetData = new Dictionary();
         _styleSheet = new StyleSheet();
         _gameStyleSheet = new StyleSheet();
         for(i = 0; i < QualityType.QUALITY_COLOR.length; )
         {
            ct = creatStyleObject(QualityType.QUALITY_COLOR[i]);
            gct = creatStyleObject(QualityType.QUALITY_COLOR[i],1);
            _styleSheetData["QT" + i] = ct;
            _styleSheet.setStyle("QT" + i,ct);
            _gameStyleSheet.setStyle("QT" + i,gct);
            i++;
         }
         for(j = 0; j <= CHAT_COLORS.length; )
         {
            ct1 = creatStyleObject(CHAT_COLORS[j]);
            gct1 = creatStyleObject(CHAT_COLORS[j],1);
            _styleSheetData["CT" + String(j)] = ct1;
            _styleSheet.setStyle("CT" + String(j),ct1);
            _gameStyleSheet.setStyle("CT" + String(j),gct1);
            j++;
         }
         for(k = 0; k <= TITLE_COLORS.length; )
         {
            ct2 = creatStyleObject(TITLE_COLORS[k]);
            gct2 = creatStyleObject(TITLE_COLORS[k],1);
            ctID = String(NewTitleManager.FIRST_TITLEID + k);
            _styleSheetData["CT" + ctID] = ct2;
            _styleSheet.setStyle("CT" + ctID,ct2);
            _gameStyleSheet.setStyle("CT" + ctID,gct2);
            k++;
         }
      }
   }
}
