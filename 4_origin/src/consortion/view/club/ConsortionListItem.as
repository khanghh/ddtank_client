package consortion.view.club
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.view.selfConsortia.Badge;
   import ddt.data.ConsortiaInfo;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class ConsortionListItem extends Sprite implements Disposeable
   {
       
      
      private var _itemBG:ScaleFrameImage;
      
      private var _vline:MutipleImage;
      
      private var _index:int;
      
      private var _info:ConsortiaInfo;
      
      private var _selected:Boolean;
      
      private var _consortionName:FilterFrameText;
      
      private var _chairMan:FilterFrameText;
      
      private var _count:FilterFrameText;
      
      private var _level:FilterFrameText;
      
      private var _exploit:FilterFrameText;
      
      private var _light:Scale9CornerImage;
      
      private var _badge:Badge;
      
      public function ConsortionListItem(index:int)
      {
         super();
         _index = index;
         init();
      }
      
      private function init() : void
      {
         _badge = new Badge();
         _itemBG = ComponentFactory.Instance.creatComponentByStylename("consortionClub.MemberListItem");
         _index % 2 == 0?_itemBG.setFrame(2):_itemBG.setFrame(1);
         _vline = ComponentFactory.Instance.creatComponentByStylename("consortionClub.MemberItemVLine");
         _consortionName = ComponentFactory.Instance.creatComponentByStylename("club.consortionName");
         _chairMan = ComponentFactory.Instance.creatComponentByStylename("club.chairMan");
         _count = ComponentFactory.Instance.creatComponentByStylename("club.count");
         _level = ComponentFactory.Instance.creatComponentByStylename("club.level");
         _exploit = ComponentFactory.Instance.creatComponentByStylename("club.exploit");
         _light = ComponentFactory.Instance.creatComponentByStylename("consortion.club.listItemlight");
         _light.visible = false;
         addChild(_itemBG);
         addChild(_vline);
         addChild(_badge);
         addChild(_consortionName);
         addChild(_chairMan);
         addChild(_count);
         addChild(_level);
         addChild(_exploit);
         addChild(_light);
         PositionUtils.setPos(_badge,"consortionClubItem.badge.pos");
      }
      
      public function set info(info:ConsortiaInfo) : void
      {
         if(_info == info)
         {
            return;
         }
         _info = info;
         _badge.badgeID = _info.BadgeID;
         _badge.visible = _info.BadgeID > 0;
         _consortionName.text = String(info.ConsortiaName);
         _chairMan.text = String(info.ChairmanName);
         _count.text = String(info.Count);
         _level.text = String(info.Level);
         _exploit.text = String(info.Honor);
      }
      
      public function get info() : ConsortiaInfo
      {
         return _info;
      }
      
      public function set selected(value:Boolean) : void
      {
         if(_selected == value)
         {
            return;
         }
         _selected = value;
         _light.visible = _selected;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set light(value:Boolean) : void
      {
         if(_selected)
         {
            return;
         }
         _light.visible = value;
      }
      
      override public function get height() : Number
      {
         if(_itemBG == null)
         {
            return 0;
         }
         return _itemBG.y + _itemBG.height;
      }
      
      public function getCellValue() : *
      {
         return _info;
      }
      
      public function setCellValue(value:*) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function set isApply(value:Boolean) : void
      {
         if(value)
         {
            alpha = 0.5;
            mouseChildren = false;
            mouseEnabled = false;
            _light.visible = false;
         }
         else
         {
            alpha = 1;
            mouseChildren = true;
            mouseEnabled = true;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _itemBG = null;
         _vline = null;
         _consortionName = null;
         _chairMan = null;
         _count = null;
         _level = null;
         _exploit = null;
         _light = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
