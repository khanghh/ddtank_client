package Indiana.item
{
   import Indiana.IndianaDataManager;
   import Indiana.analyzer.IndianaShopItemInfo;
   import bagAndInfo.cell.BaseCell;
   import bagAndInfo.cell.CellContentCreator;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class IndianaTitleCell extends BaseCell
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _info:IndianaShopItemInfo;
      
      private var _pic:CellContentCreator;
      
      private var _loadingasset:MovieClip;
      
      private var _contentWidth:Number;
      
      private var _contentHeight:Number;
      
      private var _picPos:Point;
      
      private var _selectImage:DisplayObject;
      
      public function IndianaTitleCell()
      {
         super(ComponentFactory.Instance.creatComponentByStylename("indiana.title.cell.bg"),info,true);
      }
      
      override protected function init() : void
      {
         super.init();
         overBg = ComponentFactory.Instance.creatComponentByStylename("indiana.title.cellLight");
         _selectImage = ComponentFactory.Instance.creatComponentByStylename("indiana.title.cellLight");
         _selectImage.visible = false;
         addChild(_selectImage);
      }
      
      public function set Info(value:IndianaShopItemInfo) : void
      {
         if(_info)
         {
            clearCreatingContent();
         }
         _info = value;
         info = IndianaDataManager.instance.getTemplatesByShopId(_info.ShopId);
         setChildIndex(_selectImage,numChildren - 1);
      }
      
      override protected function onMouseOver(evt:MouseEvent) : void
      {
         if(overBg && !selected)
         {
            overBg.visible = true;
            setChildIndex(overBg,numChildren - 1);
         }
      }
      
      public function set selected(value:Boolean) : void
      {
         if(!_selectImage.visible && value)
         {
            SoundManager.instance.play("008");
         }
         _selectImage.visible = value;
      }
      
      public function get selected() : Boolean
      {
         return _selectImage.visible;
      }
      
      public function get Info() : IndianaShopItemInfo
      {
         return _info;
      }
      
      override public function dispose() : void
      {
         clearLoading();
         clearCreatingContent();
         _info = null;
         ObjectUtils.disposeObject(_selectImage);
         _selectImage = null;
         super.dispose();
      }
   }
}
