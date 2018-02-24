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
      
      public function AwardsItem(){super();}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      private function removeEvents() : void{}
      
      private function createMessage() : void{}
      
      private function setChats(param1:ChatData) : void{}
      
      private function __onTextClicked(param1:TextEvent) : void{}
      
      private function getTemplateInfo(param1:int) : InventoryItemInfo{return null;}
      
      private function _showLinkGoodsInfo(param1:ItemTemplateInfo) : void{}
      
      public function set info(param1:AwardsInfo) : void{}
      
      public function get info() : AwardsInfo{return null;}
      
      override public function get height() : Number{return 0;}
      
      public function setTextFieldWidth(param1:int) : void{}
      
      public function dispose() : void{}
   }
}
