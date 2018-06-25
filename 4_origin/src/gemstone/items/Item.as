package gemstone.items
{
   import bagAndInfo.cell.PersonalInfoCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import gemstone.info.GemstListInfo;
   import gemstone.info.GemstoneInfo;
   
   public class Item extends Sprite
   {
       
      
      private var _bg:Bitmap;
      
      private var _icon:PersonalInfoCell;
      
      public var list:Vector.<GemstoneInfo>;
      
      public function Item()
      {
         super();
         _bg = ComponentFactory.Instance.creatBitmap("gemstone.bigCil");
         addChild(_bg);
         _icon = new PersonalInfoCell();
         _icon.x = 39;
         _icon.y = 39;
         addChild(_icon);
      }
      
      public function upDataIcon(info:ItemTemplateInfo) : void
      {
         if(!info)
         {
            ObjectUtils.disposeObject(_icon);
            _icon = null;
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.gemstone.curInfo.noeq"));
            return;
         }
         if(!_icon)
         {
            _icon = new PersonalInfoCell();
            _icon.x = 39;
            _icon.y = 39;
            addChild(_icon);
         }
         _icon.info = info;
      }
      
      public function updataInfo(liststone:Vector.<GemstListInfo>) : void
      {
         if(_icon)
         {
            (_icon.info as InventoryItemInfo).gemstoneList = liststone;
         }
      }
      
      public function dispose() : void
      {
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
