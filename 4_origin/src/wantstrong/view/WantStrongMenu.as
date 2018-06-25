package wantstrong.view
{
   import com.pickgliss.ui.core.Disposeable;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import wantstrong.WantStrongControl;
   import wantstrong.WantStrongManager;
   import wantstrong.model.WantStrongModel;
   
   public class WantStrongMenu extends Sprite implements Disposeable
   {
       
      
      private var _menuArr:Array;
      
      private var _titleArr:Array;
      
      private var _selectItem:WantStrongCell;
      
      private var _cellArr:Array;
      
      private var _model:WantStrongModel;
      
      public function WantStrongMenu(model:WantStrongModel)
      {
         _menuArr = [1,2,3,4,5,6,7,8];
         _titleArr = [LanguageMgr.GetTranslation("ddt.wantStrong.view.titleText"),LanguageMgr.GetTranslation("ddt.wantStrong.view.levelUp"),LanguageMgr.GetTranslation("ddt.wantStrong.view.earnMoney"),LanguageMgr.GetTranslation("ddt.wantStrong.view.artifact"),LanguageMgr.GetTranslation("ddt.wantStrong.view.findBack")];
         _cellArr = [];
         super();
         WantStrongManager.Instance.addEventListener("cellChange",cellChangeHandler);
         _model = model;
         createUI();
      }
      
      private function cellChangeHandler(event:Event) : void
      {
         if(_model.data[5].length == 0)
         {
            removeChildAt(this.numChildren - 1);
            WantStrongManager.Instance.findBackExist = false;
            setSelectItem(_cellArr[_model.activeId - 1]);
         }
      }
      
      private function createUI() : void
      {
         var i:int = 0;
         var cell:* = null;
         for(i = 0; i < _menuArr.length; )
         {
            if(_model.data[_menuArr[i]])
            {
               cell = new WantStrongCell(_model.data[_menuArr[i]],_titleArr[i]);
               cell.y = i * 54;
               cell.addEventListener("click",_cellClickedHandle);
               addChild(cell);
               _cellArr.push(cell);
            }
            i++;
         }
         if(_cellArr.length > 0)
         {
            setSelectItem(_cellArr[_model.activeId - 1]);
            WantStrongControl.Instance.setinitState(_model.data[_model.activeId]);
         }
      }
      
      protected function _cellClickedHandle(event:MouseEvent) : void
      {
         var item:WantStrongCell = event.currentTarget as WantStrongCell;
         setSelectItem(item);
         WantStrongControl.Instance.setCurrentInfo(item.info);
         SoundManager.instance.play("008");
      }
      
      private function setSelectItem(item:WantStrongCell) : void
      {
         if(item != _selectItem)
         {
            if(_selectItem)
            {
               _selectItem.selected = false;
            }
            _selectItem = item;
            _selectItem.selected = true;
         }
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         var cell:* = null;
         WantStrongManager.Instance.removeEventListener("cellChange",cellChangeHandler);
         _menuArr = null;
         _titleArr = null;
         if(_selectItem)
         {
            _selectItem.dispose();
            _selectItem = null;
         }
         i = 0;
         while(i < _cellArr.length)
         {
            cell = _cellArr[i];
            if(cell)
            {
               cell.removeEventListener("click",_cellClickedHandle);
               cell.dispose();
               cell = null;
            }
            i++;
         }
         _cellArr = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
