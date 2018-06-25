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
      
      public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void
      {
         _selectedLight.visible = isSelected;
         if(isSelected)
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
      
      public function setCellValue(value:*) : void
      {
         _data = value as GodCardListGroupInfo;
         updateView();
      }
      
      public function updateView() : void
      {
         if(_data == null)
         {
            return;
         }
         var myExchangeCount:int = GodCardRaiseManager.Instance.model.groups[_data.GroupID];
         var exchangeCount:int = GodCardRaiseManager.Instance.calculateExchangeCount(_data);
         var universal:int = GodCardRaiseManager.Instance.getMyCardCount(13);
         _nameTxt.text = _data.GroupName + "(" + exchangeCount + "/" + _data.Cards.length + ")";
         if(exchangeCount + universal >= _data.Cards.length && exchangeCount != 0 && _data.ExchangeTimes - myExchangeCount > 0)
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
