package ddt.view.caddyII.reader
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.IMEManager;
   import ddt.manager.IMManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.Helpers;
   import ddt.view.caddyII.CaddyEvent;
   import ddt.view.caddyII.CaddyModel;
   import ddt.view.chat.ChatData;
   import ddt.view.chat.ChatEvent;
   import ddt.view.chat.ChatFormats;
   import ddt.view.chat.ChatNamePanel;
   import flash.display.Sprite;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class AwardsItem extends Sprite implements Disposeable
   {
      
      public static const GOODSCLICK:String = "goods_click_awardsItem";
       
      
      private var _contentField:TextField;
      
      private var _info:AwardsInfo;
      
      private var _nameTip:ChatNamePanel;
      
      public function AwardsItem()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _contentField = ComponentFactory.Instance.creatCustomObject("caddy.readAward.ContentField");
         _contentField.defaultTextFormat = ComponentFactory.Instance.model.getSet("caddy.readAward.ContentFieldTF");
         _contentField.filters = [ComponentFactory.Instance.model.getSet("timebox.GF_22")];
         _contentField.styleSheet = ChatFormats.styleSheet;
         addChild(_contentField);
      }
      
      private function initEvents() : void
      {
         _contentField.addEventListener("link",__onTextClicked);
      }
      
      private function removeEvents() : void
      {
         _contentField.removeEventListener("link",__onTextClicked);
      }
      
      private function createMessage() : void
      {
         var buff:* = null;
         var goods:* = null;
         var itemInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(_info.TemplateId);
         var data:ChatData = new ChatData();
         var dian:String = LanguageMgr.GetTranslation("tank.view.caddy.awardsPoint") + " ";
         var gong:String = LanguageMgr.GetTranslation("tank.view.caddy.awardsGong");
         var name:String = "<font color=\'#ffffff\'>" + ChatFormats.creatBracketsTag("[" + _info.name + "]",1) + "</font>";
         var have:String = LanguageMgr.GetTranslation("tank.data.player.FightingPlayerInfo.your");
         var card:String = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.card");
         if(CaddyModel.instance.type == 6 || CaddyModel.instance.type == 9 || CaddyModel.instance.type == 8)
         {
            if(_info.zoneID == 0)
            {
               data.htmlMessage = "<font color=\'#ffad1b\'>" + dian + gong + have + _info.name;
               if(_info.channel == 1)
               {
                  data.htmlMessage = data.htmlMessage + (LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.jin") + card);
               }
               else if(_info.channel == 2)
               {
                  data.htmlMessage = data.htmlMessage + (LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.yin") + card);
               }
               else
               {
                  data.htmlMessage = data.htmlMessage + (LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.tong") + card);
               }
               data.htmlMessage = data.htmlMessage + "</font>";
            }
            else
            {
               data.htmlMessage = dian + have + "(" + _info.zoneID + ")" + LanguageMgr.GetTranslation("ddt.cardSystem.CardSell.SellText1");
            }
         }
         else
         {
            if(CaddyModel.instance.type == 2)
            {
               if(int(itemInfo.Property2) == 1)
               {
                  buff = LanguageMgr.GetTranslation("tank.view.award.Attack");
               }
               else if(int(itemInfo.Property2) == 2)
               {
                  buff = LanguageMgr.GetTranslation("tank.view.award.Defense");
               }
               else
               {
                  buff = LanguageMgr.GetTranslation("tank.view.award.Attribute");
               }
            }
            else
            {
               buff = CaddyModel.instance.AwardsBuff;
            }
            goods = " " + ChatFormats.creatGoodTag("[" + itemInfo.Name + "]",2,itemInfo.TemplateID,itemInfo.Quality,true,data);
            if(_info.isLong)
            {
               data.htmlMessage = dian + gong + LanguageMgr.GetTranslation("tank.view.award.Player") + name + buff + goods + "x" + _info.count + "(" + _info.zone + ")";
            }
            else
            {
               data.htmlMessage = dian + gong + name + buff + goods + "x" + _info.count;
            }
         }
         setChats(data);
      }
      
      private function setChats(chatData:ChatData) : void
      {
         var resultHtmlText:String = "";
         resultHtmlText = resultHtmlText + Helpers.deCodeString(chatData.htmlMessage);
         _contentField.htmlText = "<a>" + resultHtmlText + "</a>";
      }
      
      private function __onTextClicked(event:TextEvent) : void
      {
         var tipPos:* = null;
         var i:int = 0;
         var props:* = null;
         var selfZone:int = 0;
         var other:int = 0;
         var pattern:* = null;
         var str:* = null;
         var result:* = null;
         var startIdx:int = 0;
         var endIdx:int = 0;
         var pos:* = null;
         var legalIdx:int = 0;
         var rect:* = null;
         var nameTipPos:* = null;
         var newChannel:* = null;
         var itemInfo:* = null;
         SoundManager.instance.play("008");
         var data:Object = {};
         var allProperties:Array = event.text.split("|");
         for(i = 0; i < allProperties.length; )
         {
            if(allProperties[i].indexOf(":"))
            {
               props = allProperties[i].split(":");
               data[props[0]] = props[1];
            }
            i++;
         }
         if(int(data.clicktype) == 1)
         {
            selfZone = PlayerManager.Instance.Self.ZoneID;
            other = _info.zoneID;
            if(other > 0 && other != selfZone)
            {
               ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("core.crossZone.PrivateChatToUnable"));
               return;
            }
            if(IMManager.IS_SHOW_SUB)
            {
               dispatchEvent(new ChatEvent("nicknameClickToOutside",data.tagname));
            }
            else if(IMManager.Instance.isFriend(String(data.tagname)))
            {
               IMEManager.enable();
               ChatManager.Instance.output.functionEnabled = true;
               ChatManager.Instance.privateChatTo(data.tagname);
            }
            else
            {
               if(_nameTip == null)
               {
                  _nameTip = ComponentFactory.Instance.creatCustomObject("chat.NamePanel");
               }
               pattern = new RegExp(String(data.tagname),"g");
               str = _contentField.text;
               result = pattern.exec(str);
               while(result != null)
               {
                  startIdx = result.index;
                  endIdx = startIdx + String(data.tagname).length;
                  pos = _contentField.globalToLocal(new Point(StageReferance.stage.mouseX,StageReferance.stage.mouseY));
                  legalIdx = _contentField.getCharIndexAtPoint(pos.x,pos.y);
                  if(legalIdx >= startIdx && legalIdx <= endIdx)
                  {
                     _contentField.setSelection(startIdx,endIdx);
                     rect = _contentField.getCharBoundaries(endIdx);
                     nameTipPos = _contentField.localToGlobal(new Point(rect.x,rect.y));
                     _nameTip.x = nameTipPos.x + rect.width;
                     _nameTip.y = nameTipPos.y - _nameTip.getHeight;
                     break;
                  }
                  result = pattern.exec(str);
               }
               ChatManager.Instance.privateChatTo(data.tagname);
               _nameTip.playerName = String(data.tagname);
               newChannel = ChatFormats.Channel_Set[int(data.channel)];
               if(newChannel == "null" || newChannel == null)
               {
                  _nameTip.channel = " ";
               }
               else
               {
                  _nameTip.channel = newChannel;
               }
               _nameTip.message = String(data.message);
               _nameTip.setVisible = true;
            }
         }
         else if(int(data.clicktype) == 2)
         {
            tipPos = _contentField.localToGlobal(new Point(_contentField.mouseX,_contentField.mouseY));
            itemInfo = ItemManager.Instance.getTemplateById(data.templeteIDorItemID);
            itemInfo.BindType = data.isBind == "true"?0:1;
            _showLinkGoodsInfo(itemInfo);
         }
      }
      
      private function getTemplateInfo(id:int) : InventoryItemInfo
      {
         var itemInfo:InventoryItemInfo = new InventoryItemInfo();
         itemInfo.TemplateID = id;
         ItemManager.fill(itemInfo);
         return itemInfo;
      }
      
      private function _showLinkGoodsInfo(info:ItemTemplateInfo) : void
      {
         var tipPos:Point = _contentField.localToGlobal(new Point(_contentField.mouseX,_contentField.mouseY));
         var event:CaddyEvent = new CaddyEvent("goods_click_awardsItem");
         event.itemTemplateInfo = info;
         event.point = tipPos;
         dispatchEvent(event);
      }
      
      public function set info(itemInfo:AwardsInfo) : void
      {
         _info = itemInfo;
         createMessage();
      }
      
      public function get info() : AwardsInfo
      {
         return _info;
      }
      
      override public function get height() : Number
      {
         return _contentField.textHeight + 5;
      }
      
      public function setTextFieldWidth(width:int) : void
      {
         _contentField.width = width;
      }
      
      public function dispose() : void
      {
         removeEvents();
         _info = null;
         if(_contentField)
         {
            ObjectUtils.disposeObject(_contentField);
         }
         _contentField = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
