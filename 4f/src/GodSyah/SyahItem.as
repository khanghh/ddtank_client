package GodSyah
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class SyahItem extends Sprite
   {
       
      
      private var _itemBg:Bitmap;
      
      private var _cell:SyahCell;
      
      private var _mode:SyahMode;
      
      private var _info:InventoryItemInfo;
      
      private var _hp:FilterFrameText;
      
      private var _hpValue:FilterFrameText;
      
      private var _armor:FilterFrameText;
      
      private var _armorValue:FilterFrameText;
      
      private var _damage:FilterFrameText;
      
      private var _damageValue:FilterFrameText;
      
      private var _attack:FilterFrameText;
      
      private var _attackValue:FilterFrameText;
      
      private var _defense:FilterFrameText;
      
      private var _defenseValue:FilterFrameText;
      
      private var _agility:FilterFrameText;
      
      private var _agilityValue:FilterFrameText;
      
      private var _lucky:FilterFrameText;
      
      private var _luckyValue:FilterFrameText;
      
      private var _vec:Vector.<FilterFrameText>;
      
      public function SyahItem(){super();}
      
      public function setSyahItemInfo(param1:InventoryItemInfo) : void{}
      
      private function _buildUI() : void{}
      
      private function _createInfo() : void{}
      
      private function _arrangeText() : void{}
      
      public function dispose() : void{}
   }
}
