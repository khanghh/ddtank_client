package wonderfulActivity.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import wonderfulActivity.IShineableCell;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.ActivityCellVo;
   
   public class ActivityUnitListCell extends Sprite implements Disposeable, IListCell, IShineableCell
   {
       
      
      private var _bg:ScaleFrameImage;
      
      private var _selectedLight:Scale9CornerImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _data:ActivityCellVo;
      
      private var _canAwardMc:MovieClip;
      
      private var _type:int;
      
      public function ActivityUnitListCell()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("wonderful.leftview.listCellBG");
         _bg.setFrame(1);
         addChild(_bg);
         _selectedLight = ComponentFactory.Instance.creatComponentByStylename("wonderful.leftview.listCellLight");
         addChild(_selectedLight);
         _selectedLight.visible = false;
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("wonderful.leftview.listCellTxt");
         _nameTxt.setFrame(1);
         addChild(_nameTxt);
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
      
      public function setCanAwardStatus(shine:Boolean) : void
      {
         if(shine)
         {
            if(!_canAwardMc)
            {
               _canAwardMc = ComponentFactory.Instance.creat("wonderfulactivity.canAward.mc");
               _canAwardMc.scaleX = 1.1;
               _canAwardMc.y = -7;
               addChild(_canAwardMc);
            }
         }
         else
         {
            if(_canAwardMc)
            {
               _canAwardMc.stop();
            }
            ObjectUtils.disposeObject(_canAwardMc);
            _canAwardMc = null;
         }
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function setCellValue(value:*) : void
      {
         _data = value as ActivityCellVo;
         _nameTxt.text = _data.activityName;
         _type = _data.viewType;
         setCanAwardStatus(WonderfulActivityManager.Instance.stateDic[_type]);
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_selectedLight)
         {
            ObjectUtils.disposeObject(_selectedLight);
         }
         _selectedLight = null;
         if(_nameTxt)
         {
            ObjectUtils.disposeObject(_nameTxt);
         }
         _nameTxt = null;
         if(_canAwardMc)
         {
            _canAwardMc.stop();
         }
         ObjectUtils.disposeObject(_canAwardMc);
         _canAwardMc = null;
      }
   }
}
