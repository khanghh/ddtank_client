package magicHouse.magicBox
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class MagicBoxFusionItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _name:FilterFrameText;
      
      private var _shine:Bitmap;
      
      private var _cell:BagCell;
      
      private var _info:MagicBoxItemInfo;
      
      public function MagicBoxFusionItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("magichouse.magicbox.itemselected.bg");
         addChild(_bg);
         _name = ComponentFactory.Instance.creatComponentByStylename("magicbox.fusionView.itemnameTxt");
         addChild(_name);
         _shine = ComponentFactory.Instance.creatBitmap("magichouse.magicbox.itemselected.shine");
         _shine.visible = false;
         addChild(_shine);
      }
      
      public function setItemData($info:MagicBoxItemInfo) : void
      {
         _info = $info;
         var cellinfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(_info.ItemID);
         _cell = new BagCell(0,cellinfo,true,ComponentFactory.Instance.creatBitmap("magichouse.magicbox.itemselectedcell.bg"));
         addChild(_cell);
         var _loc3_:int = 52;
         _cell.height = _loc3_;
         _cell.width = _loc3_;
         PositionUtils.setPos(_cell,"magicbox.fusionview.itemcellPos");
         _cell.PicPos = new Point(2,2);
         _name.text = cellinfo.Name;
      }
      
      public function setItemShine(s:Boolean) : void
      {
         _shine.visible = s;
      }
      
      public function get info() : MagicBoxItemInfo
      {
         return _info;
      }
      
      public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_name)
         {
            ObjectUtils.disposeObject(_name);
         }
         _name = null;
         if(_shine)
         {
            ObjectUtils.disposeObject(_shine);
         }
         _shine = null;
         if(_cell)
         {
            ObjectUtils.disposeObject(_cell);
         }
         _cell = null;
      }
   }
}
