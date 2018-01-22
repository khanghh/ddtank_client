package godCardRaise.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import godCardRaise.GodCardRaiseManager;
   import godCardRaise.info.GodCardListGroupInfo;
   
   public class GodCardRaiseExchangeLeftCell extends Sprite implements Disposeable, IListCell
   {
       
      
      private var _bg:ScaleFrameImage;
      
      private var _selectedLight:Scale9CornerImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _data:GodCardListGroupInfo;
      
      private var _getExchangeBmp:Bitmap;
      
      public function GodCardRaiseExchangeLeftCell()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseExchangeLeftView.listCellBG");
         _bg.setFrame(1);
         addChild(_bg);
         _selectedLight = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseExchangeLeftView.listCellLight");
         addChild(_selectedLight);
         _selectedLight.visible = false;
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseExchangeLeftView.listCellTxt");
         _nameTxt.setFrame(1);
         addChild(_nameTxt);
         _getExchangeBmp = ComponentFactory.Instance.creatBitmap("asset.godCardRaiseExchangeLeftView.getExchangeBmp");
         _getExchangeBmp.visible = false;
         addChild(_getExchangeBmp);
         this.buttonMode = true;
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
         _selectedLight.visible = param2;
         if(param2)
         {
            _bg.setFrame(2);
            _nameTxt.setFrame(2);
         }
         else
         {
            _bg.setFrame(1);
            _nameTxt.setFrame(1);
         }
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(param1:*) : void
      {
         _data = param1 as GodCardListGroupInfo;
         updateView();
      }
      
      public function updateView() : void
      {
         if(_data == null)
         {
            return;
         }
         var _loc3_:int = GodCardRaiseManager.Instance.model.groups[_data.GroupID];
         var _loc1_:int = GodCardRaiseManager.Instance.calculateExchangeCount(_data);
         var _loc2_:int = GodCardRaiseManager.Instance.getMyCardCount(13);
         _nameTxt.text = _data.GroupName + "(" + _loc1_ + "/" + _data.Cards.length + ")";
         if(_loc1_ + _loc2_ >= _data.Cards.length && _loc1_ != 0 && _data.ExchangeTimes - _loc3_ > 0)
         {
            _getExchangeBmp.visible = true;
         }
         else
         {
            _getExchangeBmp.visible = false;
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _selectedLight = null;
         _nameTxt = null;
         _getExchangeBmp = null;
         _data = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
