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
         var _loc8_:* = null;
         var _loc4_:* = null;
         var _loc7_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(_info.TemplateId);
         var _loc5_:ChatData = new ChatData();
         var _loc9_:String = LanguageMgr.GetTranslation("tank.view.caddy.awardsPoint") + " ";
         var _loc3_:String = LanguageMgr.GetTranslation("tank.view.caddy.awardsGong");
         var _loc2_:String = "<font color=\'#ffffff\'>" + ChatFormats.creatBracketsTag("[" + _info.name + "]",1) + "</font>";
         var _loc1_:String = LanguageMgr.GetTranslation("tank.data.player.FightingPlayerInfo.your");
         var _loc6_:String = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.card");
         if(CaddyModel.instance.type == 6 || CaddyModel.instance.type == 9 || CaddyModel.instance.type == 8)
         {
            if(_info.zoneID == 0)
            {
               _loc5_.htmlMessage = "<font color=\'#ffad1b\'>" + _loc9_ + _loc3_ + _loc1_ + _info.name;
               if(_info.channel == 1)
               {
                  _loc5_.htmlMessage = _loc5_.htmlMessage + (LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.jin") + _loc6_);
               }
               else if(_info.channel == 2)
               {
                  _loc5_.htmlMessage = _loc5_.htmlMessage + (LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.yin") + _loc6_);
               }
               else
               {
                  _loc5_.htmlMessage = _loc5_.htmlMessage + (LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.tong") + _loc6_);
               }
               _loc5_.htmlMessage = _loc5_.htmlMessage + "</font>";
            }
            else
            {
               _loc5_.htmlMessage = _loc9_ + _loc1_ + "(" + _info.zoneID + ")" + LanguageMgr.GetTranslation("ddt.cardSystem.CardSell.SellText1");
            }
         }
         else
         {
            if(CaddyModel.instance.type == 2)
            {
               if(int(_loc7_.Property2) == 1)
               {
                  _loc8_ = LanguageMgr.GetTranslation("tank.view.award.Attack");
               }
               else if(int(_loc7_.Property2) == 2)
               {
                  _loc8_ = LanguageMgr.GetTranslation("tank.view.award.Defense");
               }
               else
               {
                  _loc8_ = LanguageMgr.GetTranslation("tank.view.award.Attribute");
               }
            }
            else
            {
               _loc8_ = CaddyModel.instance.AwardsBuff;
            }
            _loc4_ = " " + ChatFormats.creatGoodTag("[" + _loc7_.Name + "]",2,_loc7_.TemplateID,_loc7_.Quality,true,_loc5_);
            if(_info.isLong)
            {
               _loc5_.htmlMessage = _loc9_ + _loc3_ + LanguageMgr.GetTranslation("tank.view.award.Player") + _loc2_ + _loc8_ + _loc4_ + "x" + _info.count + "(" + _info.zone + ")";
            }
            else
            {
               _loc5_.htmlMessage = _loc9_ + _loc3_ + _loc2_ + _loc8_ + _loc4_ + "x" + _info.count;
            }
         }
         setChats(_loc5_);
      }
      
      private function setChats(param1:ChatData) : void
      {
         var _loc2_:String = "";
         _loc2_ = _loc2_ + Helpers.deCodeString(param1.htmlMessage);
         _contentField.htmlText = "<a>" + _loc2_ + "</a>";
      }
      
      private function __onTextClicked(param1:TextEvent) : void
      {
         var _loc19_:* = null;
         var _loc13_:int = 0;
         var _loc18_:* = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc15_:* = null;
         var _loc16_:* = null;
         var _loc4_:* = null;
         var _loc10_:int = 0;
         var _loc14_:int = 0;
         var _loc12_:* = null;
         var _loc11_:int = 0;
         var _loc9_:* = null;
         var _loc3_:* = null;
         var _loc17_:* = null;
         var _loc8_:* = null;
         SoundManager.instance.play("008");
         var _loc7_:Object = {};
         var _loc2_:Array = param1.text.split("|");
         _loc13_ = 0;
         while(_loc13_ < _loc2_.length)
         {
            if(_loc2_[_loc13_].indexOf(":"))
            {
               _loc18_ = _loc2_[_loc13_].split(":");
               _loc7_[_loc18_[0]] = _loc18_[1];
            }
            _loc13_++;
         }
         if(int(_loc7_.clicktype) == 1)
         {
            _loc6_ = PlayerManager.Instance.Self.ZoneID;
            _loc5_ = _info.zoneID;
            if(_loc5_ > 0 && _loc5_ != _loc6_)
            {
               ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("core.crossZone.PrivateChatToUnable"));
               return;
            }
            if(IMManager.IS_SHOW_SUB)
            {
               dispatchEvent(new ChatEvent("nicknameClickToOutside",_loc7_.tagname));
            }
            else if(IMManager.Instance.isFriend(String(_loc7_.tagname)))
            {
               IMEManager.enable();
               ChatManager.Instance.output.functionEnabled = true;
               ChatManager.Instance.privateChatTo(_loc7_.tagname);
            }
            else
            {
               if(_nameTip == null)
               {
                  _nameTip = ComponentFactory.Instance.creatCustomObject("chat.NamePanel");
               }
               _loc15_ = new RegExp(String(_loc7_.tagname),"g");
               _loc16_ = _contentField.text;
               _loc4_ = _loc15_.exec(_loc16_);
               while(_loc4_ != null)
               {
                  _loc10_ = _loc4_.index;
                  _loc14_ = _loc10_ + String(_loc7_.tagname).length;
                  _loc12_ = _contentField.globalToLocal(new Point(StageReferance.stage.mouseX,StageReferance.stage.mouseY));
                  _loc11_ = _contentField.getCharIndexAtPoint(_loc12_.x,_loc12_.y);
                  if(_loc11_ >= _loc10_ && _loc11_ <= _loc14_)
                  {
                     _contentField.setSelection(_loc10_,_loc14_);
                     _loc9_ = _contentField.getCharBoundaries(_loc14_);
                     _loc3_ = _contentField.localToGlobal(new Point(_loc9_.x,_loc9_.y));
                     _nameTip.x = _loc3_.x + _loc9_.width;
                     _nameTip.y = _loc3_.y - _nameTip.getHeight;
                     break;
                  }
                  _loc4_ = _loc15_.exec(_loc16_);
               }
               ChatManager.Instance.privateChatTo(_loc7_.tagname);
               _nameTip.playerName = String(_loc7_.tagname);
               _loc17_ = ChatFormats.Channel_Set[int(_loc7_.channel)];
               if(_loc17_ == "null" || _loc17_ == null)
               {
                  _nameTip.channel = " ";
               }
               else
               {
                  _nameTip.channel = _loc17_;
               }
               _nameTip.message = String(_loc7_.message);
               _nameTip.setVisible = true;
            }
         }
         else if(int(_loc7_.clicktype) == 2)
         {
            _loc19_ = _contentField.localToGlobal(new Point(_contentField.mouseX,_contentField.mouseY));
            _loc8_ = ItemManager.Instance.getTemplateById(_loc7_.templeteIDorItemID);
            _loc8_.BindType = _loc7_.isBind == "true"?0:1;
            _showLinkGoodsInfo(_loc8_);
         }
      }
      
      private function getTemplateInfo(param1:int) : InventoryItemInfo
      {
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         _loc2_.TemplateID = param1;
         ItemManager.fill(_loc2_);
         return _loc2_;
      }
      
      private function _showLinkGoodsInfo(param1:ItemTemplateInfo) : void
      {
         var _loc3_:Point = _contentField.localToGlobal(new Point(_contentField.mouseX,_contentField.mouseY));
         var _loc2_:CaddyEvent = new CaddyEvent("goods_click_awardsItem");
         _loc2_.itemTemplateInfo = param1;
         _loc2_.point = _loc3_;
         dispatchEvent(_loc2_);
      }
      
      public function set info(param1:AwardsInfo) : void
      {
         _info = param1;
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
      
      public function setTextFieldWidth(param1:int) : void
      {
         _contentField.width = param1;
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
