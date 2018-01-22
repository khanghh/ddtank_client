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
      
      public static function formatChatStyle(param1:ChatData) : void
      {
         if(param1.htmlMessage != "")
         {
            return;
         }
         param1.msg = StringHelper.rePlaceHtmlTextField(param1.msg);
         var _loc5_:Array = getTagsByChannel(param1);
         var _loc2_:String = creatChannelTag(param1.channel,param1.bigBuggleType,param1);
         var _loc3_:String = creatSenderTag(param1);
         var _loc4_:String = creatContentTag(param1);
         param1.htmlMessage = _loc5_[0] + _loc2_ + _loc3_ + _loc4_ + _loc5_[1] + "<BR>";
      }
      
      public static function formatComplexChatStyle(param1:ChatData) : void
      {
         var _loc5_:int = 0;
         if(param1.htmlMessage != "")
         {
            return;
         }
         param1.msg = StringHelper.rePlaceHtmlTextField(param1.msg);
         var _loc4_:Array = getTagsByChannel(param1);
         var _loc3_:String = creatContentTag(param1);
         var _loc2_:Array = _loc3_.split("@@");
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            param1.htmlMessage = param1.htmlMessage + (_loc4_[2 * _loc5_] + _loc2_[_loc5_] + _loc4_[2 * _loc5_ + 1]);
            _loc5_++;
         }
         param1.htmlMessage = param1.htmlMessage + "<BR>";
      }
      
      public static function creatBracketsTag(param1:String, param2:int, param3:Array = null, param4:ChatData = null) : String
      {
         var _loc12_:* = null;
         var _loc5_:int = 0;
         var _loc9_:* = null;
         var _loc15_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc14_:* = null;
         var _loc8_:int = 0;
         var _loc13_:* = null;
         if(param4 != null && param4.channel == 14 && param4.msg.indexOf("http") != -1)
         {
            param1 = "<u><a href=\"event:clicktype:" + param2.toString() + "|senderId:" + param4.senderID + "|roomId:" + param4.roomId + "|password:" + param4.password + "|source:" + param4.msg + "\">" + param1 + "</a>" + "</u>";
         }
         if(param2 == 101)
         {
            param1 = "<u><a href=\"event:clicktype:" + param2.toString() + "|senderId:" + param4.senderID + "|roomId:" + param4.roomId + "|password:" + param4.password + "\">" + param1 + "</a>" + "</u>";
         }
         if(param2 == 888)
         {
            if(param4.senderID != PlayerManager.Instance.Self.ID)
            {
               param1 = "<u><a href=\"event:clicktype:" + param2.toString() + "|senderId:" + param4.senderID + "|roomId:" + param4.roomId + "|password:" + param4.password + "\">" + param1 + "</a>" + "</u>";
            }
            else
            {
               param1 = "【" + param4.sender + "】" + LanguageMgr.GetTranslation("tank.newyearFood.view.bugleTxt");
            }
         }
         if(param2 == 889)
         {
            param1 = param1.split("|")[0] + "@@" + "<u>" + "<a href=\"event:" + "clicktype:" + param2.toString() + "\">" + param1.split("|")[1] + "</a>" + "</u>";
         }
         if(param2 == 107)
         {
            param1 = "【" + param4.sender + "】" + LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionSellLeftView.bugleTxt",param4.price,param4.mouthful,param4.auctionGoodName,param4.itemCount);
            if(param4.playerCharacterID != PlayerManager.Instance.Self.ID)
            {
               param1 = param1 + ("，<u><a href=\"event:clicktype:" + param2.toString() + "|senderId:" + param4.senderID + "|nickName:" + param4.playerName + "|price:" + param4.price + "|mouthful:" + param4.mouthful + "|auctionID:" + param4.auctionID + "\">" + LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionSellLeftView.clickToBuy") + "</a></u>");
            }
         }
         else if(param2 == 102 || param2 == 108 || param2 == 110 || param2 > CLICK_ACT_TIP)
         {
            param1 = param1.split("|")[0] + "@@" + "<u>" + "<a href=\"event:" + "clicktype:" + param2.toString() + "|rewardType:" + param4.actId + "\">" + param1.split("|")[1] + "</a>" + "</u>";
         }
         else if(param2 == 113)
         {
            param1 = param1.split("|")[0] + "<u>" + "<a href=\"event:" + "clicktype:" + param2.toString() + "\">" + param1.split("|")[1] + "</a>" + "</u>";
         }
         else if(param2 == 103)
         {
            _loc12_ = param1.split("|");
            param1 = _loc12_[0];
            if(param4.receiver != PlayerManager.Instance.Self.NickName)
            {
               param1 = param1.replace("[" + param4.receiver + "]","<a href=\"event:clicktype:1|tagname:" + param4.receiver + "|zoneID:-1\">" + Helpers.enCodeString("[" + param4.receiver + "]") + "</a>");
            }
            if(_loc12_.length > 1)
            {
               param1 = param1 + ("@@<u><a href=\"event:clicktype:" + param2 + "|tagname:" + param4.receiver + "\">" + _loc12_[1] + "</a>" + "</u>");
            }
            else
            {
               param1 = param1 + "@@";
            }
         }
         else if(param2 == 104)
         {
            _loc5_ = param1.indexOf(".") + 1;
            param1 = param1.slice(0,_loc5_) + "<u>" + "<a href=\"event:" + "clicktype:" + param2.toString() + "\">" + param1.slice(_loc5_,param1.length) + "</a></u>";
         }
         else if(param2 == 106)
         {
            param1 = param1 + ("<u><a href=\"event:clicktype:" + param2.toString() + "\"><FONT  COLOR=\'#8dff1e\'>" + LanguageMgr.GetTranslation("notAlertAgain") + "</FONT></a></u>");
         }
         else if(param2 == 109)
         {
            _loc9_ = param1.split("|");
            _loc15_ = /\[([^\]]*)]*/g;
            _loc10_ = _loc9_[0].match(_loc15_);
            _loc11_ = _loc10_[0].substr(1,_loc10_[0].length - 2);
            param1 = _loc9_[0].replace("[" + _loc11_ + "]","<a href=\"event:clicktype:1|tagname:" + _loc11_ + "|zoneID:" + String(param4.zoneID) + "|zoneName:" + String(param4.zoneName) + "|" + "\">" + Helpers.enCodeString("[" + _loc11_ + "]") + "</a>") + "@@<u>" + _loc9_[1].replace(_loc9_[1],"<a href=\"event:clicktype:" + param2.toString() + "|tagname:" + _loc11_ + "|zoneID:" + String(param4.zoneID) + "|zoneName:" + String(param4.zoneName) + "|" + "\">" + Helpers.enCodeString(_loc9_[1]) + "</a></u>");
         }
         else if(param2 == 111)
         {
            param1 = param1 + ("<u><a href=\"event:clicktype:" + param2.toString() + "\">" + LanguageMgr.GetTranslation("redpackage.clickToGain") + "</a></u>");
         }
         else if(param2 == 999)
         {
            param1 = param1 + ("<font color=\"" + RedEnvelopeItem.redcolorList[param4.redType - 1] + "\"> " + LanguageMgr.GetTranslation("ddt.redEnvelope.red" + String(param4.redType)) + "</font>");
            param1 = param1 + ("<u><a href=\"event:clicktype:" + param2.toString() + "\">" + LanguageMgr.GetTranslation("ddt.redEnvelope.chatClick") + "</a></u>");
         }
         else if(param2 == 112)
         {
            param1 = "<u><a href=\"event:clicktype:" + param2.toString() + "\">" + param1 + "</a>" + "</u>";
         }
         else
         {
            _loc6_ = /\[([^\]]*)]*/g;
            _loc7_ = param1.match(_loc6_);
            _loc14_ = "";
            if(param3)
            {
               _loc14_ = param3.join("|");
            }
            _loc8_ = 0;
            while(_loc8_ < _loc7_.length)
            {
               _loc13_ = _loc7_[_loc8_].substr(1,_loc7_[_loc8_].length - 2);
               if(param2 != 1 || _loc13_ != PlayerManager.Instance.Self.NickName || _loc13_ == PlayerManager.Instance.Self.NickName && param4 && param4.zoneID != PlayerManager.Instance.Self.ZoneID)
               {
                  if(param4)
                  {
                     _loc14_ = _loc14_ + ("channel:" + param4.channel);
                  }
                  if(param4 && param4.channel == 12)
                  {
                     param1 = param1.replace("[" + _loc13_ + "]","<a href=\"event:clicktype:" + param2.toString() + "|tagname:" + _loc13_ + "|zoneID:" + String(param4.zoneID) + "|zoneName:" + String(param4.zoneName) + "|" + _loc14_ + "\">" + Helpers.enCodeString("[" + _loc13_ + "]") + "</a>");
                  }
                  else if(_loc13_ == Channel_Set[12])
                  {
                     param1 = "";
                  }
                  else if(param4)
                  {
                     if(param4.senderID >= 0)
                     {
                        param1 = param1.replace("[" + _loc13_ + "]","<a href=\"event:clicktype:" + param2.toString() + "|tagname:" + _loc13_ + "|zoneID:" + String(param4.zoneID) + "|zoneName:" + String(param4.zoneName) + "|" + _loc14_ + "\">" + Helpers.enCodeString("[" + _loc13_ + "]") + "</a>");
                     }
                     else
                     {
                        param1 = param1.replace("[" + _loc13_ + "]","<a href=\"event:clicktype:" + param2.toString() + "|tagname:" + _loc13_ + "|senderID:" + param4.senderID + "|zoneID:" + String(param4.zoneID) + "|zoneName:" + String(param4.zoneName) + "|" + _loc14_ + "\">" + Helpers.enCodeString("[" + _loc13_ + "]") + "</a>");
                     }
                  }
                  else
                  {
                     param1 = param1.replace("[" + _loc13_ + "]","<a href=\"event:clicktype:" + param2.toString() + "|tagname:" + _loc13_ + "|" + _loc14_ + "\">" + Helpers.enCodeString("[" + _loc13_ + "]") + "</a>");
                  }
               }
               else
               {
                  param1 = param1.replace("[" + _loc13_ + "]",Helpers.enCodeString("[" + _loc13_ + "]"));
               }
               _loc8_++;
            }
         }
         return param1;
      }
      
      public static function creatGoodTag(param1:String, param2:int, param3:int, param4:int, param5:Boolean, param6:ChatData = null, param7:String = "", param8:int = -1) : String
      {
         var _loc13_:int = 0;
         var _loc14_:* = null;
         var _loc9_:Array = getTagsByQuality(param4);
         var _loc10_:RegExp = /\[([^\]]*)]*/g;
         var _loc11_:Array = param1.match(_loc10_);
         var _loc12_:int = param6.zoneID;
         _loc13_ = 0;
         while(_loc13_ < _loc11_.length)
         {
            _loc14_ = _loc11_[_loc13_].substr(1,_loc11_[_loc13_].length - 2);
            param1 = param1.replace("[" + _loc14_ + "]",_loc9_[0] + "<a href=\"event:" + "clicktype:" + param2.toString() + "|type:" + param8 + "|tagname:" + _loc14_ + "|isBind:" + param5.toString() + "|templeteIDorItemID:" + param3.toString() + "|key:" + param7 + "|zoneID:" + _loc12_ + "\">" + Helpers.enCodeString("[" + _loc14_ + "]") + "</a>" + _loc9_[1]);
            _loc13_++;
         }
         return param1;
      }
      
      public static function getColorByChannel(param1:int) : int
      {
         return CHAT_COLORS[param1];
      }
      
      public static function getColorByBigBuggleType(param1:int) : int
      {
         return BIG_BUGGLE_COLOR[param1];
      }
      
      public static function getTagsByChannel(param1:ChatData) : Array
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(param1.channel != 21)
         {
            return ["<CT" + param1.channel.toString() + ">","</CT" + param1.channel.toString() + ">"];
         }
         _loc2_ = [];
         _loc3_ = 0;
         while(_loc3_ < param1.childChannelArr.length)
         {
            _loc2_.push("<CT" + param1.childChannelArr[_loc3_].toString() + ">");
            _loc2_.push("</CT" + param1.childChannelArr[_loc3_].toString() + ">");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function getTagsByQuality(param1:int) : Array
      {
         return ["<QT" + param1.toString() + ">","</QT" + param1.toString() + ">"];
      }
      
      public static function getTextFormatByChannel(param1:int) : TextFormat
      {
         return _formats[param1];
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
      
      private static function getBigBuggleTypeString(param1:int) : String
      {
         return BIG_BUGGLE_TYPE_STRING[param1 - 1];
      }
      
      private static function creatChannelTag(param1:int, param2:int = 0, param3:ChatData = null) : String
      {
         var _loc4_:String = "";
         if(Channel_Set[param1] && param1 != 2)
         {
            if(param2 == 0)
            {
               if(param1 != 15)
               {
                  _loc4_ = creatBracketsTag("[" + Channel_Set[param1] + "]",0,["channel:" + param1.toString()]);
               }
               else
               {
                  _loc4_ = creatBracketsTag("[" + Channel_Set[param1] + "]" + "&lt;" + param3.zoneName + "&gt;",0,["channel:" + param1.toString()]);
               }
            }
            else
            {
               _loc4_ = "[" + getBigBuggleTypeString(param2) + Channel_Set[param1] + "]";
            }
         }
         return _loc4_;
      }
      
      private static function creatContentTag(param1:ChatData) : String
      {
         var _loc2_:Number = NaN;
         var _loc6_:int = 0;
         var _loc9_:* = null;
         var _loc8_:* = null;
         var _loc4_:* = 0;
         var _loc5_:* = null;
         var _loc3_:String = param1.msg;
         var _loc7_:uint = 0;
         if(param1.link)
         {
            param1.link.sortOn("index");
            var _loc12_:int = 0;
            var _loc11_:* = param1.link;
            for each(var _loc10_ in param1.link)
            {
               _loc2_ = _loc10_.ItemID;
               _loc6_ = _loc10_.TemplateID;
               _loc9_ = ItemManager.Instance.getTemplateById(_loc6_);
               _loc8_ = _loc10_.key;
               _loc4_ = uint(_loc10_.index + _loc7_);
               if(_loc2_ <= 0)
               {
                  if(_loc9_.CategoryID == 26)
                  {
                     _loc5_ = creatGoodTag("[" + _loc9_.Name + "]",6,_loc2_,_loc9_.Quality,true,param1,_loc8_);
                  }
                  else
                  {
                     _loc5_ = creatGoodTag("[" + _loc9_.Name + "]",2,_loc9_.TemplateID,_loc9_.Quality,true,param1);
                  }
               }
               else if(_loc9_ == null)
               {
                  if(_loc6_ == 0)
                  {
                     _loc5_ = creatGoodTag("[" + LanguageMgr.GetTranslation("tank.view.card.chatLinkText0") + "]",5,_loc2_,2,true,param1,_loc8_);
                  }
                  else
                  {
                     _loc5_ = creatGoodTag("[" + String(_loc6_) + LanguageMgr.GetTranslation("tank.view.card.chatLinkText") + "]",5,_loc2_,2,true,param1,_loc8_);
                  }
               }
               else
               {
                  _loc5_ = creatGoodTag("[" + _loc9_.Name + "]",3,_loc2_,_loc9_.Quality,true,param1,_loc8_);
               }
               _loc3_ = _loc3_.substring(0,_loc4_) + _loc5_ + _loc3_.substring(_loc4_);
               _loc7_ = _loc7_ + _loc5_.length;
            }
         }
         if(param1.type == 113)
         {
            _loc3_ = creatBracketsTag(_loc3_,113,null,param1);
            return creatBracketsTag(_loc3_,113,null,param1);
         }
         if(param1.type == 110)
         {
            _loc3_ = creatBracketsTag(_loc3_,110,null,param1);
            return creatBracketsTag(_loc3_,110,null,param1);
         }
         if(param1.type == 109)
         {
            _loc3_ = creatBracketsTag(_loc3_,109,null,param1);
            return creatBracketsTag(_loc3_,109,null,param1);
         }
         if(param1.type == 99)
         {
            return StringHelper.reverseHtmlTextField(param1.msg);
         }
         if(param1.type == 100)
         {
            _loc3_ = creatBracketsTag(_loc3_,100,null,param1);
            return creatBracketsTag(_loc3_,100,null,param1);
         }
         if(param1.type == 101)
         {
            _loc3_ = creatBracketsTag(_loc3_,101,null,param1);
            return creatBracketsTag(_loc3_,101,null,param1);
         }
         if(param1.type == 888)
         {
            _loc3_ = creatBracketsTag(_loc3_,888,null,param1);
            return creatBracketsTag(_loc3_,888,null,param1);
         }
         if(param1.type == 889)
         {
            _loc3_ = creatBracketsTag(_loc3_,889,null,param1);
            return creatBracketsTag(_loc3_,889,null,param1);
         }
         if(param1.type == 107)
         {
            _loc3_ = creatBracketsTag(_loc3_,107,null,param1);
            return creatBracketsTag(_loc3_,107,null,param1);
         }
         if(param1.type == 102)
         {
            _loc3_ = creatBracketsTag(_loc3_,102,null,param1);
            return creatBracketsTag(_loc3_,102,null,param1);
         }
         if(param1.type == 102 || param1.type == 108)
         {
            _loc3_ = creatBracketsTag(_loc3_,param1.type,null,param1);
            return creatBracketsTag(_loc3_,param1.type,null,param1);
         }
         if(param1.type == 108 || param1.type > CLICK_ACT_TIP)
         {
            _loc3_ = creatBracketsTag(_loc3_,param1.type,null,param1);
            return creatBracketsTag(_loc3_,param1.type,null,param1);
         }
         if(param1.type == 103)
         {
            _loc3_ = creatBracketsTag(_loc3_,103,null,param1);
            return creatBracketsTag(_loc3_,103,null,param1);
         }
         if(param1.type == 104 || param1.type == 105)
         {
            _loc3_ = creatBracketsTag(_loc3_,param1.type,null,param1);
            return creatBracketsTag(_loc3_,param1.type,null,param1);
         }
         if(param1.type == 106)
         {
            _loc3_ = creatBracketsTag(_loc3_,param1.type,null,param1);
            return creatBracketsTag(_loc3_,param1.type,null,param1);
         }
         if(param1.type == 111)
         {
            _loc3_ = creatBracketsTag(_loc3_,param1.type,null,param1);
            return creatBracketsTag(_loc3_,param1.type,null,param1);
         }
         if(param1.type == 999)
         {
            _loc3_ = creatBracketsTag(_loc3_,param1.type,null,param1);
            return creatBracketsTag(_loc3_,param1.type,null,param1);
         }
         if(param1.channel == 14)
         {
            _loc3_ = creatBracketsTag(_loc3_,890,null,param1);
            return creatBracketsTag(_loc3_,890,null,param1);
         }
         if(param1.channel <= 5)
         {
            if(param1.type == 1 || param1.type == 4)
            {
               _loc3_ = creatBracketsTag(_loc3_,1,null,param1);
               return creatBracketsTag(_loc3_,1,null,param1);
            }
            return _loc3_;
         }
         _loc3_ = creatBracketsTag(_loc3_,1,null,param1);
         return creatBracketsTag(_loc3_,1,null,param1);
      }
      
      private static function creatSenderTag(param1:ChatData) : String
      {
         var _loc2_:String = "";
         if(param1.sender == "")
         {
            return _loc2_;
         }
         if(param1.channel == 2)
         {
            if(param1.zoneID <= 0 || !param1.zoneName)
            {
               if(param1.sender == PlayerManager.Instance.Self.NickName)
               {
                  _loc2_ = creatBracketsTag(LanguageMgr.GetTranslation("tank.view.chatsystem.sendTo") + "[" + param1.receiver + "]: ",1,null,param1);
               }
               else
               {
                  _loc2_ = creatBracketsTag("[" + param1.sender + "]" + LanguageMgr.GetTranslation("tank.view.chatsystem.privateSayToYou"),1,null,param1);
               }
            }
            else if(param1.sender == PlayerManager.Instance.Self.NickName && param1.senderID == PlayerManager.Instance.Self.ID)
            {
               _loc2_ = creatBracketsTag(LanguageMgr.GetTranslation("tank.view.chatsystem.sendTo") + "&lt;" + param1.zoneName + "&gt;" + "[" + param1.receiver + "]: ",1,null,param1);
            }
            else
            {
               _loc2_ = creatBracketsTag("&lt;" + param1.zoneName + "&gt;" + "[" + param1.sender + "]" + LanguageMgr.GetTranslation("tank.view.chatsystem.privateSayToYou"),1,null,param1);
            }
         }
         else if(param1.zoneID == PlayerManager.Instance.Self.ZoneID || param1.zoneID <= 0)
         {
            _loc2_ = creatBracketsTag("[" + param1.sender + "]: ",1,null,param1);
         }
         else
         {
            _loc2_ = creatBracketsTag("[" + param1.sender + "]: ",4,null,param1);
         }
         return _loc2_;
      }
      
      public static function replaceUnacceptableChar(param1:String) : String
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < unacceptableChar.length)
         {
            param1 = param1.replace(unacceptableChar[_loc2_],"");
            _loc2_++;
         }
         return param1;
      }
      
      private static function creatStyleObject(param1:int, param2:uint = 0) : Object
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         switch(int(param2))
         {
            case 0:
               _loc4_ = "13";
               break;
            case 1:
               _loc4_ = "12";
         }
         _loc3_ = {
            "color":"#" + param1.toString(16),
            "leading":"5",
            "fontFamily":"Arial",
            "display":"inline",
            "fontSize":_loc4_
         };
         return _loc3_;
      }
      
      private static function setupFormat() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _formats = new Dictionary();
         _loc2_ = 0;
         while(_loc2_ < CHAT_COLORS.length)
         {
            _loc1_ = new TextFormat();
            _loc1_.font = "Arial";
            _loc1_.size = 13;
            _loc1_.color = CHAT_COLORS[_loc2_];
            _formats[_loc2_] = _loc1_;
            _loc2_++;
         }
      }
      
      private static function setupStyle() : void
      {
         var _loc10_:int = 0;
         var _loc9_:* = null;
         var _loc8_:* = null;
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc7_:int = 0;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc1_:* = null;
         _styleSheetData = new Dictionary();
         _styleSheet = new StyleSheet();
         _gameStyleSheet = new StyleSheet();
         _loc10_ = 0;
         while(_loc10_ < QualityType.QUALITY_COLOR.length)
         {
            _loc9_ = creatStyleObject(QualityType.QUALITY_COLOR[_loc10_]);
            _loc8_ = creatStyleObject(QualityType.QUALITY_COLOR[_loc10_],1);
            _styleSheetData["QT" + _loc10_] = _loc9_;
            _styleSheet.setStyle("QT" + _loc10_,_loc9_);
            _gameStyleSheet.setStyle("QT" + _loc10_,_loc8_);
            _loc10_++;
         }
         _loc6_ = 0;
         while(_loc6_ <= CHAT_COLORS.length)
         {
            _loc4_ = creatStyleObject(CHAT_COLORS[_loc6_]);
            _loc2_ = creatStyleObject(CHAT_COLORS[_loc6_],1);
            _styleSheetData["CT" + String(_loc6_)] = _loc4_;
            _styleSheet.setStyle("CT" + String(_loc6_),_loc4_);
            _gameStyleSheet.setStyle("CT" + String(_loc6_),_loc2_);
            _loc6_++;
         }
         _loc7_ = 0;
         while(_loc7_ <= TITLE_COLORS.length)
         {
            _loc5_ = creatStyleObject(TITLE_COLORS[_loc7_]);
            _loc3_ = creatStyleObject(TITLE_COLORS[_loc7_],1);
            _loc1_ = String(NewTitleManager.FIRST_TITLEID + _loc7_);
            _styleSheetData["CT" + _loc1_] = _loc5_;
            _styleSheet.setStyle("CT" + _loc1_,_loc5_);
            _gameStyleSheet.setStyle("CT" + _loc1_,_loc3_);
            _loc7_++;
         }
      }
   }
}
