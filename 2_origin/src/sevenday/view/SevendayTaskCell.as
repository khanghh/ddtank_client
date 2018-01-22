package sevenday.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class SevendayTaskCell extends Sprite implements Disposeable
   {
       
      
      private var _cell:BagCell;
      
      private var _rewardCompleteIcon:Bitmap;
      
      private var _isGet:Boolean;
      
      public function SevendayTaskCell()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _cell = new BagCell(0);
         addChild(_cell);
         _rewardCompleteIcon = ComponentFactory.Instance.creatBitmap("asset.sevenday.isgetgift");
         _rewardCompleteIcon.visible = false;
         addChild(_rewardCompleteIcon);
      }
      
      public function update(param1:ItemTemplateInfo, param2:int = 1) : void
      {
         _cell.info = param1;
         _cell.setCount(param2);
      }
      
      public function get isGet() : Boolean
      {
         return _isGet;
      }
      
      public function set isGet(param1:Boolean) : void
      {
         _isGet = param1;
         _rewardCompleteIcon.visible = isGet;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_cell);
         _cell = null;
         ObjectUtils.disposeObject(_rewardCompleteIcon);
         _rewardCompleteIcon = null;
      }
   }
}
