package wonderfulActivity.views
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.list.IListModel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import wonderfulActivity.IShineableCell;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.ActivityCellVo;
   import wonderfulActivity.event.WonderfulActivityEvent;
   
   public class ActivityLeftUnitView extends Sprite implements Disposeable
   {
      
      public static const TYPE_WONDER:int = 2;
      
      public static const TYPE_LIMINT:int = 1;
      
      public static const TYPE_NEWSERVER:int = 3;
      
      public static const TYPE_EXCHANGE_ACT:int = 4;
       
      
      private var _selectedBtn:SelectedButton;
      
      private var _bg:ScaleBitmapImage;
      
      private var _list:ListPanel;
      
      private var _type:int;
      
      private var dataList:Array;
      
      private var _selectedValue:ActivityCellVo;
      
      private var _updateFun:Function;
      
      private var _currentID:String;
      
      private var hasClickSound:Boolean = true;
      
      public function ActivityLeftUnitView(type:int)
      {
         _currentID = "-1";
         super();
         _type = type;
         initView();
         initEvent();
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function setData(value:Array, rightFun:Function) : void
      {
         dataList = value;
         _updateFun = rightFun;
         initData();
      }
      
      private function initView() : void
      {
         _selectedBtn = getSelectedBtn();
         addChild(_selectedBtn);
         _bg = ComponentFactory.Instance.creatComponentByStylename("wonderful.leftview.listBG");
         _bg.visible = false;
         addChild(_bg);
         _list = ComponentFactory.Instance.creatComponentByStylename("wonderful.leftview.unitCellList");
         _list.visible = false;
         addChild(_list);
      }
      
      private function initEvent() : void
      {
         _selectedBtn.addEventListener("click",__selectedBtnClick);
         _list.list.addEventListener("listItemClick",__itemClick);
      }
      
      public function initData() : void
      {
         _list.vectorListModel.clear();
         _list.vectorListModel.appendAll(dataList);
         _list.list.updateListView();
      }
      
      private function getSelectedBtn() : SelectedButton
      {
         var tmp:* = null;
         switch(int(_type) - 1)
         {
            case 0:
               tmp = ComponentFactory.Instance.creatComponentByStylename("wonderful.leftview.limitSelectedBtn");
               break;
            case 1:
               tmp = ComponentFactory.Instance.creatComponentByStylename("wonderful.leftview.wonderfulSelectedBtn");
               break;
            case 2:
               tmp = ComponentFactory.Instance.creatComponentByStylename("wonderful.leftview.newServerSelectedBtn");
               break;
            case 3:
               tmp = ComponentFactory.Instance.creatComponentByStylename("wonderful.leftview.exchangeActSelectedBtn");
         }
         return tmp;
      }
      
      private function __selectedBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _bg.visible = _selectedBtn.selected;
         _list.visible = _selectedBtn.selected;
         extendSelecteTheFirst();
         dispatchEvent(new WonderfulActivityEvent("selected_change"));
      }
      
      private function __itemClick(event:ListItemEvent) : void
      {
         WonderfulActivityManager.Instance.currentItem(event.cell as IShineableCell);
         _selectedValue = event.cellValue as ActivityCellVo;
         if(_selectedValue.id == _currentID)
         {
            return;
         }
         _currentID = _selectedValue.id;
         if(hasClickSound)
         {
            SoundManager.instance.play("008");
         }
         hasClickSound = true;
         return;
         §§push(_updateFun(_selectedValue.id));
      }
      
      public function extendSelecteTheFirst() : void
      {
         hasClickSound = false;
         _currentID = "-1";
         extendHandler();
         autoSelect();
      }
      
      private function autoSelect() : void
      {
         var i:int = 0;
         var tmpSelectedIndex:int = 0;
         var intPoint:* = null;
         var model:IListModel = _list.list.model;
         var len:int = model.getSize();
         if(len > 0)
         {
            if(WonderfulActivityManager.Instance.isSkipFromHall)
            {
               for(i = 0; i < len; )
               {
                  if(WonderfulActivityManager.Instance.skipType == (model.getElementAt(i) as ActivityCellVo).id)
                  {
                     _selectedValue = model.getElementAt(i) as ActivityCellVo;
                     WonderfulActivityManager.Instance.isSkipFromHall = false;
                     break;
                  }
                  i++;
               }
               if(!_selectedValue)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("wonderfulActivity.close"));
                  WonderfulActivityManager.Instance.isSkipFromHall = false;
                  _selectedValue = model.getElementAt(0) as ActivityCellVo;
               }
            }
            else if(!_selectedValue)
            {
               _selectedValue = model.getElementAt(0) as ActivityCellVo;
            }
            tmpSelectedIndex = getIndexInModel(_selectedValue.id);
            if(tmpSelectedIndex < 0)
            {
               tmpSelectedIndex = 0;
            }
            intPoint = new IntPoint(0,model.getCellPosFromIndex(tmpSelectedIndex));
            _list.list.viewPosition = intPoint;
            _list.list.currentSelectedIndex = tmpSelectedIndex;
         }
         else
         {
            _selectedValue = null;
         }
      }
      
      private function getIndexInModel(id:String) : int
      {
         var i:int = 0;
         var model:IListModel = _list.list.model;
         for(i = 0; i <= model.getSize() - 1; )
         {
            if(model.getElementAt(i).id == id)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      private function extendHandler() : void
      {
         _selectedBtn.selected = true;
         _selectedBtn.enable = false;
         _list.visible = true;
         _bg.visible = true;
      }
      
      public function unextendHandler() : void
      {
         _selectedBtn.selected = false;
         _selectedBtn.enable = true;
         _bg.visible = false;
         _list.visible = false;
      }
      
      public function getModelSize() : int
      {
         return _list.list.model.getSize();
      }
      
      override public function get height() : Number
      {
         if(_selectedBtn && _bg)
         {
            if(_bg.visible)
            {
               return _bg.y + _bg.height;
            }
            return _selectedBtn.height;
         }
         return super.height;
      }
      
      private function removeEvent() : void
      {
         if(_selectedBtn)
         {
            _selectedBtn.removeEventListener("click",__selectedBtnClick);
         }
         if(_list && _list.list)
         {
            _list.list.removeEventListener("listItemClick",__itemClick);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_selectedBtn)
         {
            ObjectUtils.disposeObject(_selectedBtn);
         }
         _selectedBtn = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
      }
      
      public function get bg() : ScaleBitmapImage
      {
         return _bg;
      }
      
      public function set bg(value:ScaleBitmapImage) : void
      {
         _bg = value;
      }
      
      public function get list() : ListPanel
      {
         return _list;
      }
      
      public function set list(value:ListPanel) : void
      {
         _list = value;
      }
   }
}
