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
      
      public function WantStrongMenu(param1:WantStrongModel)
      {
         _menuArr = [1,2,3,4,5];
         _titleArr = [LanguageMgr.GetTranslation("ddt.wantStrong.view.titleText"),LanguageMgr.GetTranslation("ddt.wantStrong.view.levelUp"),LanguageMgr.GetTranslation("ddt.wantStrong.view.earnMoney"),LanguageMgr.GetTranslation("ddt.wantStrong.view.artifact"),LanguageMgr.GetTranslation("ddt.wantStrong.view.findBack")];
         _cellArr = [];
         super();
         WantStrongManager.Instance.addEventListener("cellChange",cellChangeHandler);
         _model = param1;
         createUI();
      }
      
      private function cellChangeHandler(param1:Event) : void
      {
         if(_model.data[5].length == 0)
         {
            removeChildAt(4);
            WantStrongManager.Instance.findBackExist = false;
            setSelectItem(_cellArr[_model.activeId - 1]);
         }
      }
      
      private function createUI() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < _menuArr.length)
         {
            if(_model.data[_menuArr[_loc2_]])
            {
               _loc1_ = new WantStrongCell(_model.data[_menuArr[_loc2_]],_titleArr[_loc2_]);
               _loc1_.y = _loc2_ * 54;
               _loc1_.addEventListener("click",_cellClickedHandle);
               addChild(_loc1_);
               _cellArr.push(_loc1_);
            }
            _loc2_++;
         }
         if(_cellArr.length > 0)
         {
            setSelectItem(_cellArr[_model.activeId - 1]);
            WantStrongControl.Instance.setinitState(_model.data[_model.activeId]);
         }
      }
      
      protected function _cellClickedHandle(param1:MouseEvent) : void
      {
         var _loc2_:WantStrongCell = param1.currentTarget as WantStrongCell;
         setSelectItem(_loc2_);
         WantStrongControl.Instance.setCurrentInfo(_loc2_.info);
         SoundManager.instance.play("008");
      }
      
      private function setSelectItem(param1:WantStrongCell) : void
      {
         if(param1 != _selectItem)
         {
            if(_selectItem)
            {
               _selectItem.selected = false;
            }
            _selectItem = param1;
            _selectItem.selected = true;
         }
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         WantStrongManager.Instance.removeEventListener("cellChange",cellChangeHandler);
         _menuArr = null;
         _titleArr = null;
         if(_selectItem)
         {
            _selectItem.dispose();
            _selectItem = null;
         }
         _loc2_ = 0;
         while(_loc2_ < _cellArr.length)
         {
            _loc1_ = _cellArr[_loc2_];
            if(_loc1_)
            {
               _loc1_.removeEventListener("click",_cellClickedHandle);
               _loc1_.dispose();
               _loc1_ = null;
            }
            _loc2_++;
         }
         _cellArr = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
