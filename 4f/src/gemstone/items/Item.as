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
      
      public function Item(){super();}
      
      public function upDataIcon(param1:ItemTemplateInfo) : void{}
      
      public function updataInfo(param1:Vector.<GemstListInfo>) : void{}
      
      public function dispose() : void{}
   }
}
